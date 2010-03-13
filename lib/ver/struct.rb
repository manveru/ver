module VER
  # A caching wrapper for Struct from Ruby core.
  #
  # When reloading source in VER, sometimes a file will contain a class that
  # inherits from Struct.new
  # The issue is that Struct.new always returns a new class, even if the members
  # are the same.
  # This results in a "TypeError: superclass mismatch" exception.
  # There are workarounds that use the defined? keyword to check whether the
  # subclass has been defined yet, but that's not very intuitive and results in
  # issues for documentation.
  # Not to mention it's more mental overhead and more to type.
  #
  # This class simply defines its own {VER::Struct.new} method, which uses a
  # constant Hash to keep all the Struct superclasses created so far along with
  # the parameters used to create them.
  # When it receives the same arguments, it returns the same superclass, problem solved.
  #
  # Of course, if you change the arguments, source reloading will fail again
  # until you restart VER or undefine the constant that holds the subclass.
  class Struct < ::Struct
    CACHE = {}

    def self.new(*args)
      CACHE[args] ||= super
    end
  end
end
