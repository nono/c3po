# encoding: utf-8
require 'nokogiri'

class C3po
  module Translator
    class Bing
      attr_reader :base_url

      def initialize(to_be_translated)
        @to_be_translated = to_be_translated
        @default = {
          :appId => C3po::Translator::Configuration.bing_api_key,
        }
      end

      # Build a query for the Bing Translate api.
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
        @base_url = 'http://api.microsofttranslator.com/V2/Http.svc/Translate'
        @default.merge({:text => @to_be_translated,
                        :from => from.to_s,
                        :to => to.to_s
                      })
      end

      def build_languages_query
        @base_url = 'http://api.microsofttranslator.com/V1/Http.svc/GetLanguages'
        @default
      end

      # Build a query for detect method of Bing Translate api.
      #
      # @example
      #   build_detect_query
      #
      # @return [Hash] Hash of param.
      #
      # @since 0.0.1
      #
      def build_detect_query
        @base_url = 'http://api.microsofttranslator.com/V2/Http.svc/Detect'
        @default.merge({:text => @to_be_translated})
      end

      # Parse xml response from Bing webservice.
      #
      # XML is serious business.
      #
      # @example
      #   parse my_xml
      #
      # @param [String] response Json representation
      #
      # @return [String] Translated string.
      #
      # @since 0.0.1
      #
      def parse(response)
        xpath = Nokogiri::XML(response).xpath('/')
        return xpath.text unless xpath.children.empty?
        response.to_s.split("\r\n")
      end
    end #Bing
  end # Translator
end #C3po
