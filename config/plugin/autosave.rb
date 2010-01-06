# Autosave every second when inactive and changes have been made.

VER.startup_hook do
  VER.when_inactive_for 1000 do
    VER.layout.views.each do |view|
      text = view.text

      next if text.pristine? || text.persisted?

      text.file_save
    end
  end
end
