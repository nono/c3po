# encoding: utf-8
class C3po
  module Translator

    # Translate a string.
    #
    # @example :
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
      fetch build_query(from, to)
    end

    # Identify language.
    #
    # @example :
    #   translator = C3po.new('translate')
    #   translator.is
    #
    # @return [Symbol] the identified language
    #
    # @since 0.0.1
    #
    def is
    end

    # Check language.
    #
    # @example :
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
      language == is
    end

  end #Translator
end #C3po
