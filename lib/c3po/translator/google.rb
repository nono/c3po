# encoding: utf-8
require 'yajl'

class C3po
  module Translator
    class Google
      attr_accessor :base_url

      def initialize(to_be_translated)
        @to_be_translated = to_be_translated
        @base_url = 'https://www.googleapis.com/language/translate/v2'
      end

      # Build a query for Google Translate api.
      #
      # @exemple :
      #   build_query :fr, :en
      #
      # @params [Symbol] Language to be translated from.
      #         [Symbol] Language to be translated to.
      #
      # @return [Hash] Hash of params.
      #
      # @since 0.0.1
      #
      def build_query(from, to)
        {
          :key => C3po::Translator::Configuration.google_api_key,
          :q => @to_be_translated,
          :source => from.to_s,
          :target => to.to_s
        }
      end

      # Parse json response from Google webservice.
      #
      # @exemple :
      #   parse my_json
      #
      # @params [String] response Json representation
      #
      # @return [String] Translated string.
      #
      # @since 0.0.1
      #
      def parse(response)
        Yajl::Parser.parse(response)['data']['translations'][0]['translatedText']
      end

    end #Google
  end # Translator
end #C3po
