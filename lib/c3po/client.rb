# encoding: utf-8
require 'typhoeus'

class C3po
  module Client

    # Query a web service.
    #
    # Returns a translated string or an array of errors.
    #
    # @example
    #   fetch {:key => 'MYAPIKEY',
    #          :q => 'Something to translate'
    #         }
    #
    # @param [Hash] Query containing all the params.
    #
    # @return [String] Translated string.
    #
    # @since 0.0.1
    #
    def fetch(query)
      request = set_request query
      request.on_complete {|response| process_reponse response}

      hydra = Typhoeus::Hydra.hydra
      hydra.queue request
      hydra.run

      @response if @errors.empty?
    end

    private

    # Create a Typhoeus request object.
    #
    # @example
    #   set_request {:key => 'MYAPIKEY',
    #                :q => 'Something to translate'
    #               }
    #
    # @param [Hash] Query containing all the params.
    #
    # @return [Typhoeus::Request] Translated string.
    #
    # @since 0.0.1
    #
    def set_request(query)
      Typhoeus::Request.new @adaptor.base_url, :params => query
    end

    # Process response.
    #
    # @example
    #   process_reponse response
    #
    # @param [Typhoeus::Response] Typhoeus response object.
    #
    # @return [Typhoeus::Request] Translated string.
    #
    # @since 0.0.1
    #
    def process_reponse(response)
      if response.success?
        begin
          @response = @adaptor.parse response.body
        rescue
          @errors << 'Invalid response'
        end
      elsif response.timed_out?
        @errors << 'timeout'
      else
        @errors << "HTTP request failed: #{response.code}"
      end
    end

  end # Client
end # C3po
