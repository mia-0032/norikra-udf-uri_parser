require 'java'
require 'norikra/udf'

module Norikra
  module UDF
    class SplitUri < Norikra::UDF::SingleRow
      def self.init
        require 'norikra-udf-uri_parser.jar'
      end

      def definition
        ["splituri", "jp.ys.mia.norikra.udf.UriParser", "split_uri"]
      end
    end

    class SplitQuery < Norikra::UDF::SingleRow
      def self.init
        require 'norikra-udf-uri_parser.jar'
      end

      def definition
        ["splitquery", "jp.ys.mia.norikra.udf.UriParser", "split_query"]
      end
    end
  end
end
