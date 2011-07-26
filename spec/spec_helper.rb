# encoding: utf-8
path = File.expand_path(File.dirname(__FILE__) + '/../lib/')
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'c3po'

def file_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
end

def request_helper(translator, query, body)
  request = Typhoeus::Request.new translator.base, :params => query
  hydra = Typhoeus::Hydra.hydra
  response = Typhoeus::Response.new(:code => 200, :headers => "", :body => body, :time => 0.3)
  hydra.stub(:get, request.url).and_return(response)
end
