module VER
  Log = Logger.new('/tmp/ver.log')

  def self.debug(*args)
    Log.debug(*args)
  end

  def self.info(*args)
    Log.info(*args)
  end

  def self.warn(*args)
    Log.warn(*args)
  end

  def self.error(*args)
    Log.error(*args)
  end
end
