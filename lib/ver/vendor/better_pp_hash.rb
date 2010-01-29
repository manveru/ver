require 'pp'

class PP
  module PPMethods
    # make hashes prettier
    def pp_hash(obj)
      group(1, '{', '}') do
        seplist(obj, nil, :each_pair) do |k, v|
          group do
            if k.is_a?(Symbol) && k =~ /^\w+$/
              text k.to_s
              text ': '
            else
              pp k
              text ' => '
            end

            group(1) do
              breakable ''
              pp v
            end
          end
        end
      end
    end
  end
end
