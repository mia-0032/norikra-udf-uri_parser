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

This query returns below.

```javascript
{
  "val":"bar"
}
```

### splituri(expression, string)

Second argument accepts `scheme`,`userinfo`,`host`,`port`,`path`,`opaque`,`query`,`fragment`.

#### Example queries:

##### 1. Using path field.

```sql
SELECT
  -- path is like "/hoge?foo=bar#top"
  splituri(path, 'scheme')   AS scheme,
  splituri(path, 'userinfo') AS userinfo,
  splituri(path, 'host')     AS host,
  splituri(path, 'port')     AS port,
  splituri(path, 'path')     AS path,
  splituri(path, 'opaque')   AS opaque,
  splituri(path, 'query')    AS query,
  splituri(path, 'fragment') AS fragment
FROM access_log
```

This query returns below.

```javascript
{
  "port":"",
  "host":"",
  "scheme":"",
  "query":"foo=bar",
  "opaque":"",
  "path":"/hoge",
  "userinfo":"",
  "fragment":"top"
}
```

##### 2. Using URL filed.

```sql
SELECT
  -- referer is like "http://example.com/hoge?foo=bar#top"
  splituri(referer, 'scheme')   AS scheme,
  splituri(referer, 'userinfo') AS userinfo,
  splituri(referer, 'host')     AS host,
  splituri(referer, 'port')     AS port,
  splituri(referer, 'path')     AS path,
  splituri(referer, 'opaque')   AS opaque,
  splituri(referer, 'query')    AS query,
  splituri(referer, 'fragment') AS fragment
FROM access_log
```

This query returns below.

```javascript
{
  "port":"",
  "host":"example.com",
  "scheme":"http",
  "query":"foo=bar",
  "opaque":"",
  "path":"/hoge",
  "userinfo":"",
  "fragment":"top"
}
```

### splitquery(expression, string)

Second argument is the key that you want to get the value.

#### Example queries:

##### 1. key=value parameter.

```sql
SELECT
  -- query is like "foo1=bar1&foo2=bar2&foo3=bar3"
  splitquery(query, 'foo1') AS foo1,
  splitquery(query, 'foo2') AS foo2,
  splitquery(query, 'foo3') AS foo3
FROM access_log
```

This query returns below.

```javascript
{
  "foo3":"bar3",
  "foo2":"bar2",
  "foo1":"bar1"
}
```

##### 2. key\[\]=values parameter.

```sql
SELECT
  -- query is like "foo[]=bar1&foo[]=bar2&foo[]=bar3"
  splitquery(query, 'foo[]') AS foo
FROM access_log
```

This query returns below.

```javascript
{
  "foo":[
    "bar1",
    "bar2",
    "bar3"
  ]
}
```

##### 3. Only key parameter.

```sql
SELECT
  -- query is like "test&foo1=bar1&foo2=bar2"
  splitquery(query, 'test') AS test,
  splitquery(query, 'other') AS other
FROM access_log
```

This query returns below.

```javascript
{
  "other":null,
  "test":""
}
```

## TODO

- Add method returns all query value as hash. (ex. `splitquery("foo=bar&buzz=123")` return `{"foo":"bar","buzz":123}`)

## Contributing

1. Fork it ( https://github.com/mia-0032/norikra-udf-uri_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
