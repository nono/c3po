# encoding: utf-8
class C3po

  class NoGivenString < Exception; end
  class NoGivenProvider < Exception; end

  autoload :Translator,      'c3po/translator'
  autoload :Client,          'c3po/client'

  module Translator
    autoload :Configuration, 'c3po/translator/configuration'
    autoload :Result,        'c3po/translator/result'
    autoload :Google,        'c3po/translator/google'
    autoload :Bing,          'c3po/translator/bing'
  end

  include Client
  include C3po::Translator

  attr_accessor :base_url, :to_be_translated, :errors, :result, :adaptor

  # Define a translator object.
  #
  # @example
  #   translator = C3po.new('to be translated')
  #   translator.translate(:fr, :en)
  #
  # @param [ String ] string String on witch we will work
  #
  # @since 0.0.1
  #
  def initialize(to_be_translated = nil)
    raise NoGivenString if to_be_translated.nil?
    @to_be_translated = to_be_translated
    select_provider
    @base_url = self.class.base_url
    @result = C3po::Translator::Result.new
    @errors = []
  end

  class << self

    attr_accessor :base_url

    # Define a configure block.
    #
    # Delegates to C3po::Translator::Configuration
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
      C3po::Translator::Configuration.configure(&block)
    end

  end # self

  private

  # Include provider based on configuration
  #
  # @since 0.0.1
  #
  def select_provider
    case provider
    when :google
      @adaptor = Google.new @to_be_translated
    when :bing
      @adaptor = Bing.new @to_be_translated
    else
      raise NoGivenProvider
    end
  end

  # Choose provider based on configuration
  #
  # If Configuration.provider is an Array,
  # take a random value from as provider
  #
  # @since 0.0.1
  #
  def provider
    provider = Configuration.provider
    @provider ||= provider.is_a?(Array) ? provider.sample : provider
  end

end # C3po
