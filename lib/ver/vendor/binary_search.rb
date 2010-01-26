module VER
  # Simple mechanism to do binary search over positive integer space.
  # This allows you to find the last number that is valid for some condition
  # passed in a block in a fast manner rather than doing simple brute-force.
  #
  # @example for finding the highest value for pack('n')
  #
  #   works = 0
  #   fails = 100_000
  #   BinarySearch.new(works, fails).run do |current|
  #     [current].pack('n').unpack('n')[0] == current
  #   end
  #
  #   # Will tell you that 65535 is the highest value that didn't fail
  #
  # The reason this exists was to find the highest value for the time-to-live
  # arugment to MemCache#store.
  #
  # @example for finding the highest ttl of memcache
  #
  #   require 'memcache'
  #   m = MemCache.new(['localhost:11211:1'], :namespace => 'manveru-session')
  #   works = 1
  #   fails = 100000000
  #
  #   BinarySearch.new(works, fails).run do |current|
  #     m.set('session', 1, current)
  #     m['session']
  #   end
  #
  #   # For those curious, it's 2592000
  class BinarySearch
    def initialize(works, fails, &block)
      @works, @fails = works, fails
      run(&block) if block_given?
    end

    def run
      works, fails = @works, @fails
      current = works
      step = 0

      loop do
        success = yield(current)

        if success
          works = current
          current = works + ((fails - works) / 2)
        else
          fails = current
          current = works + ((fails - works) / 2)
        end

        break if current == fails or current == works
        step += 1
      end

      return current
    end
  end
end
