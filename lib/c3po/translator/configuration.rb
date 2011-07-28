# encoding: utf-8
class C3po
  module Translator

    class Configuration

      class << self

        attr_accessor :provider, :google_api_key, :bing_api_key

        # Define a configure block.
        #
        # config.provider can be an Array. In this case,
        # provider will be randomly choosen from it.
        #
        # @example Define the option.
        #   C3po.configure do |config|
        #     config.provider = :google
        #     config.google_api_key = "MYAPIKEY"
        #   end
        #
        # @param [ Proc ] block The block getting called.
        #
        # @since 0.0.1
        #
        def configure(&block)
          yield self
        end

      end # self
    end # Configuration
  end # Translator
end #C3po
