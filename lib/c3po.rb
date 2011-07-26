# encoding: utf-8
require 'typhoeus'
require 'yajl'

class C3po

  autoload :Translator,      'c3po/translator'
  autoload :Client,          'c3po/client'

  module Translator
    autoload :Configuration, 'c3po/translator/configuration'
    autoload :Google,        'c3po/translator/google'
    autoload :Bing,          'c3po/translator/bing'
  end

  include Client
  include C3po::Translator

  attr_accessor :base, :to_be_translated, :errors, :result

  # Define a translator object.
  #
  # @example :
  #   translator = C3po.new('to be translated')
  #   translator.translate(:fr, :en)
  #
  # @param [ String ] string String on witch we will work
  #
  # @since 0.0.1
  #
  def initialize(to_be_translated = nil)
    select_provider
    @to_be_translated = to_be_translated
    @base = BASE_URL
    @errors = []
  end

  class << self

    # Define a configure block.
    #
    # Delegates to C3po::Translator::Configuration
    #
    # @example Define the option.
    #   C3po.configure do |config|
    #     config.provider = :google
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

  # Choose provider based on configuration
  #
  # @since 0.0.1
  #
  def select_provider
    case C3po::Translator::Configuration.provider
    when :google
      self.class.send :include, Google
    when :bing
      self.class.send :include, Bing
    end
  end

end # C3po
