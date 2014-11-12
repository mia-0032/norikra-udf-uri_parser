# Norikra::Udf::UriParser

This is [Norikra](http://norikra.github.io/) UDF.

`splituri` UDF return value corresponds to specified element in uri string like `http://example.com/hoge`.

`splitquery` UDF return value corresponds to target key in query string like `hoge=foo`.

[![Build Status](https://travis-ci.org/mia-0032/norikra-udf-uri_parser.svg)](https://travis-ci.org/mia-0032/norikra-udf-uri_parser)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'norikra-udf-uri_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install norikra-udf-uri_parser

## Usage

```sql
SELECT
  -- path is like "/hoge?foo=bar"
  splitquery(splituri(path, 'query'), 'foo') AS val
FROM access_log
```

This Norikra query returns below.

```
{"val":"bar"}
```

### splituri(expression, string)

Second argument accepts `scheme`,`userinfo`,`host`,`port`,`path`,`opaque`,`query`,`fragment`.

### splitquery(expression, string)

Second argument is the key that you want to get the value.


## TODO

- Add method all query value as hash. (ex. `splitquery("foo=bar&buzz=123")` return `{"foo":"bar","buzz":123}`)

## Contributing

1. Fork it ( https://github.com/mia-0032/norikra-udf-uri_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
