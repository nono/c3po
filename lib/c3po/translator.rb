# encoding: utf-8
class C3po
  module Translator

    # Translate a string.
    #
    # @example
    #   translator = C3po.new('translate')
    #   translator.translate(:en, :fr)
    #
    # @param [ Symbol ] language to translate from
    # @param [ Symbol ] language to translate to
    #
    # @return [String] the translated string
    #
    # @since 0.0.1
    #
    def translate(from, to)
      @result.translation ||= fetch @adaptor.build_query(from, to)
    end

    # Grab languages list from provider.
    #
    # @example
    #   translator = C3po.new('translate')
    #   translator.languages
    #
    # @return [Array] the languages list
    #
    # @since 0.0.1
    #
    def languages
      @result.languages ||= fetch @adaptor.build_languages_query
    end

    # Identify language.
    #
    # @example
    #   translator = C3po.new('translate')
    #   translator.is
    #
    # @return [String] the identified language
    #
    # @since 0.0.1
    #
    def is
      @result.language ||= fetch @adaptor.build_detect_query
    end

    # Check language.
    #
    # @example
    #   translator = C3po.new('translate')
    #   translator.is? :fr
    #
    # @param [ Symbol ] language to check
    #
    # @return [Boolean]
    #
    # @since 0.0.1
    #
    def is?(language)
      language.to_s == is
    end

  end #Translator
end #C3po
