require 'cgi'
require 'java'
require 'uri'

java_package 'jp.ys.mia.norikra.udf'

class SplitUri
  @@elements = {
      :scheme => 0,
      :userinfo => 1,
      :host => 2,
      :port => 3,
      :path => 5,
      :opaque => 6,
      :query => 7,
      :fragment => 8
  }

  def self.execute(uri, element_key)
    element_key = element_key.to_sym
    unless @@elements.has_key?(element_key)
      return nil
    end

    begin
      parsed_uri = URI.split(uri)
    rescue URI::InvalidURIError => e
      return nil
    end

    result = parsed_uri[@@elements[element_key]]
    if result.nil?
      ''
    else
      result
    end
  end
end

class SplitQuery
  def self.execute(query_text, key)
    query = CGI::parse(query_text)

    unless query.has_key?(key)
      return nil
    end

    case query[key].length
    when 0 then
      ''
    when 1 then
      query[key][0]
    else
      query[key]
    end
  end
end
