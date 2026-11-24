# frozen_string_literal: true

require 'open3'
require 'fileutils'

# Provides one private Xvfb display (plus a window manager) for a whole spec
# run, so the per-file spec processes neither pop windows on the desktop
# nor each need their own X server. A window manager is mandatory: the
# bind/event specs synthesise key events that are only delivered to a window
# with real keyboard focus, which a bare Xvfb never grants.
module HeadlessDisplay
  module_function

  XVFB_TIMEOUT = 10
  WM_TIMEOUT = 5

  # Xvfb and openbox chatter (harmless xkbcomp keymap warnings from the F23/F24
  # dual-mapping in xkeyboard-config, socket-probe noise from -displayfd) goes
  # here instead of onto the spec output. Not discarded: the path is announced
  # and the file persists (project tmp/, not the ephemeral shell TMPDIR) so real
  # server errors stay diagnosable after the run.
  def log_path
    @log_path ||= File.expand_path('../../tmp/xserver.log', __dir__)
  end

  # Yields an env hash ({'DISPLAY' => ...}) for spec subprocesses.
  # TK_SPEC_DISPLAY=:0 bypasses Xvfb and runs on that display instead,
  # restoring the previous visible-on-desktop behaviour.
  def with_display
    if (display = ENV.fetch('TK_SPEC_DISPLAY', nil))
      return yield('DISPLAY' => display)
    end

    %w[Xvfb openbox xprop].each do |bin|
      next if system("command -v #{bin} >/dev/null")

      abort "#{bin} not found on PATH (enter the dev shell), " \
            'or set TK_SPEC_DISPLAY=:0 to run on an existing display'
    end

    FileUtils.mkdir_p(File.dirname(log_path))
    log = File.open(log_path, 'w')
    warn "X server output -> #{log_path}"
    xvfb_pid, display = start_xvfb(log)
    wm_pid = start_wm(display, log)
    yield('DISPLAY' => display)
  ensure
    [wm_pid, xvfb_pid].compact.each { |pid| terminate(pid) }
    log&.close
  end

  # Xvfb picks a free display number itself and writes it to -displayfd once
  # the server accepts connections, so there is no lockfile race and no need
  # to poll for readiness.
  def start_xvfb(log)
    reader, writer = IO.pipe
    pid = Process.spawn('Xvfb', '-displayfd', writer.fileno.to_s,
                        '-screen', '0', '1280x800x24', '-nolisten', 'tcp',
                        writer.fileno => writer.fileno, out: log, err: log)
    writer.close

    unless reader.wait_readable(XVFB_TIMEOUT)
      terminate(pid)
      abort "Xvfb did not report a display within #{XVFB_TIMEOUT}s (see #{log_path})"
    end

    [pid, ":#{reader.gets.strip}"]
  ensure
    reader&.close
    writer&.close unless writer&.closed?
  end

  # Start openbox and wait until it registers as the EWMH window manager;
  # specs that run before a WM exists hang waiting for focus.
  def start_wm(display, log)
    env = { 'DISPLAY' => display }
    pid = Process.spawn(env, 'openbox', out: log, err: log)

    deadline = Time.now + WM_TIMEOUT
    loop do
      out, status = Open3.capture2e(env, 'xprop', '-root', '_NET_SUPPORTING_WM_CHECK')
      return pid if status.success? && out =~ /window id/

      if Time.now >= deadline
        terminate(pid)
        abort "openbox did not become the window manager on #{display} within #{WM_TIMEOUT}s"
      end
      sleep 0.05
    end
  end

  def terminate(pid)
    Process.kill('TERM', pid)
    Process.wait(pid)
  rescue Errno::ESRCH, Errno::ECHILD
    nil
  end
end
