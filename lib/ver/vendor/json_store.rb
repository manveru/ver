require 'json'
require 'pstore'

class JSON::Store < PStore
  def dump(table)
    JSON.pretty_unparse(@table)
  end

  def load(content)
    JSON.load(content)
  end

  EMPTY_MARSHAL_DATA = {}.to_json
  EMPTY_MARSHAL_CHECKSUM = Digest::MD5.digest(EMPTY_MARSHAL_DATA)

  def empty_marshal_data
    EMPTY_MARSHAL_DATA
  end

  def empty_marshal_checksum
    EMPTY_MARSHAL_CHECKSUM
  end
end
