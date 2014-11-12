require 'norikra/udf_spec_helper'

include Norikra::UDFSpecHelper

require 'norikra/udf/uri_parser'

describe Norikra::UDF::SplitUri do
  udf_function Norikra::UDF::SplitUri

  it 'returns value corresponds to target element if url given' do
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "scheme")).to eql("http")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "userinfo")).to eql("")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "host")).to eql("example.com")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "port")).to eql("")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "path")).to eql("/hogehoge")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "opaque")).to eql("")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "query")).to eql("foo=bar")
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar#frgmt", "fragment")).to eql("frgmt")

    expect(fcall(:splituri, "http://hoge-san:password@example.com/hogehoge?foo=bar", "userinfo")).to eql("hoge-san:password")
    expect(fcall(:splituri, "http://example.com:80/hogehoge?foo=bar", "port")).to eql("80")
    expect(fcall(:splituri, "mailto:nospam@localhost", "opaque")).to eql("nospam@localhost")
  end

  it 'returns value corresponds to target element if path given' do
    expect(fcall(:splituri, "/hogehoge?foo=bar", "scheme")).to eql("")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "userinfo")).to eql("")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "host")).to eql("")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "port")).to eql("")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "path")).to eql("/hogehoge")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "opaque")).to eql("")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "query")).to eql("foo=bar")
    expect(fcall(:splituri, "/hogehoge?foo=bar", "fragment")).to eql("")
  end

  it 'returns nil if invalid element specified.' do
    expect(fcall(:splituri, "http://example.com/hogehoge?foo=bar", "test")).to be_nil
  end

  it 'returns nil if invalid uri specified.' do
    expect(fcall(:splituri, "http://example com/hogehoge?foo=bar", "host")).to be_nil
  end
end

describe Norikra::UDF::SplitQuery do
  udf_function Norikra::UDF::SplitQuery

  it 'returns value corresponds to target key' do
    expect(fcall(:splitquery, "hoge=foo", "hoge")).to eql("foo")
    expect(fcall(:splitquery, "hoge1=foo&hoge2=bar", "hoge1")).to eql("foo")
    expect(fcall(:splitquery, "hoge[]=foo&hoge[]=bar", "hoge[]")).to match_array(["foo", "bar"])
  end

  it 'returns nil if query does not contain target key' do
    expect(fcall(:splitquery, "", "hoge")).to be_nil
    expect(fcall(:splitquery, "hoge=foo", "hoge1")).to be_nil
    expect(fcall(:splitquery, "hoge1=foo&hoge2=bar", "hoge3")).to be_nil
  end

  it 'returns empty string if target key does not have value' do
    expect(fcall(:splitquery, "hoge", "hoge")).to eql('')
    expect(fcall(:splitquery, "hoge1=foo&hoge2=bar&hoge3", "hoge3")).to eql('')
  end
end
