# encoding: utf-8
require 'yajl'

class C3po
  module Translator
    class Google
      attr_reader :base_url

      def initialize(to_be_translated = nil)
        @to_be_translated = to_be_translated
        @default = {
          :key => C3po::Translator::Configuration.google_api_key
        }
      end

      # Build a query for Google Translate api.
      #
      # @example
      #   build_query :fr, :en
      #
      # @param [Symbol] Language to be translated from.
      #         [Symbol] Language to be translated to.
      #
      # @return [Hash] Hash of param.
      #
      # @since 0.0.1
      #
      def build_query(from, to)
        @base_url = 'https://www.googleapis.com/language/translate/v2'
        @default.merge({:q => @to_be_translated,
                        :source => from.to_s,
                        :target => to.to_s
                      })
      end

      # Build a query for languages method of Google Translate api.
      #
      # @example
      #   build_languages_query
      #
      # @return [Hash] Hash of param.
      #
      # @since 0.0.1
      #
      def build_languages_query
        @base_url = 'https://www.googleapis.com/language/translate/v2/languages'
        @default
      end

      # Build a query for detect method of Google Translate api.
      #
      # @example
      #   build_detect_query
      #
      # @return [Hash] Hash of param.
      #
      # @since 0.0.1
      #
      def build_detect_query
        @base_url = 'https://www.googleapis.com/language/translate/v2/detect'
        @default.merge({:q => @to_be_translated})
      end

      # Parse json response from Google webservice.
      #
      # @example
      #   parse my_json
      #
      # @param [String] response Json representation
      #
      # @return [String] Translated string.
      # @return [String] Detected language.
      # @return [Array]  Languages list.
      #
      # @since 0.0.1
      #
      def parse(response)
        data = Yajl::Parser.parse(response)['data']
        if data['translations']
          data['translations'][0]['translatedText']
        elsif data['detections']
          data['detections'][0][0]["language"]
        else
          data['languages'].inject([]) {|languages, value| languages << value['language']}
        end
      end

    end #Google
  end # Translator
end #C3po
