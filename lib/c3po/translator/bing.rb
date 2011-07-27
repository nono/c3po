# encoding: utf-8
require 'nokogiri'

class C3po
  module Translator
    class Bing
      attr_accessor :base_url

      def initialize(to_be_translated)
        @to_be_translated = to_be_translated
        @base_url = 'http://api.microsofttranslator.com/V2/Http.svc/Translate'
      end

      # Build a query for the Bing Translate api.
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
          :appId => C3po::Translator::Configuration.bing_api_key,
          :text => @to_be_translated,
          :from => from.to_s,
          :to => to.to_s
        }
      end

      # Parse xml response from Bing webservice.
      #
      # @exemple :
      #   parse my_xml
      #
      # @params [String] response Json representation
      #
      # @return [String] Translated string.
      #
      # @since 0.0.1
      #
      def parse(response)
        Nokogiri::XML(response).xpath('/').text
      end
    end #Bing
  end # Translator
end #C3po
