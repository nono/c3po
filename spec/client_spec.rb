# encoding: utf-8
require 'spec_helper'

describe C3po do
  it 'should be true' do
    defined?(C3po).should be_true
  end

  describe C3po::Translator::Configuration do
    context 'google as provider' do

      before do
        C3po.configure do |config|
          config.provider = :google
          config.google_api_key = 'MYAPIKEY'
        end
      end

      it 'Configuration should be autoload' do
        defined?(C3po::Translator::Configuration).should be_true
      end

      it 'should respond_to configure' do
        C3po.respond_to?(:configure).should be_true
      end

      it 'should have a provider method' do
        C3po::Translator::Configuration.provider.should eq(:google)
      end

      it 'should have a google_api_key method' do
        C3po::Translator::Configuration.google_api_key.should eq('MYAPIKEY')
      end
    end

    context 'bing as provider' do

      before do
        C3po.configure do |config|
          config.provider = :bing
          config.google_api_key = 'MYAPIKEY'
        end
      end

      it 'Configuration should be autoload' do
        defined?(C3po::Translator::Configuration).should be_true
      end

      it 'should respond_to configure' do
        C3po.respond_to?(:configure).should be_true
      end

      it 'should have a provider method' do
        C3po::Translator::Configuration.provider.should eq(:bing)
      end

      it 'should have a google_api_key method' do
        C3po::Translator::Configuration.google_api_key.should eq('MYAPIKEY')
      end
    end

  end


  describe C3po::Translator::Google do
    let(:translator) { C3po.new('to be translated')}
    let(:json_response) {File.open(file_path('multiple.json')).read}

    before do
      C3po.configure do |config|
        config.provider = :google
        config.google_api_key = 'MYAPIKEY'
      end
    end

    it 'should build a query hash' do
      translator.build_query(:fr, :en).should eq({:key=>"MYAPIKEY", :q=>"to be translated", :source=>'fr', :target=> 'en'})
    end

    it 'should read json response' do
      translator.parse(json_response).should eq('Hallo Welt')
    end
  end

  describe 'Request' do
    context 'Google adapter' do

      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('multiple.json')).read}
      let(:query) {{:key=>"MYAPIKEY", :q=>"to be translated", :source=>"fr", :target=>"en"}}

      before do
        C3po.configure do |config|
          config.provider = :google
          config.google_api_key = 'MYAPIKEY'
        end
        request_helper(translator, query, json_response)
        translator.translate(:fr, :en)
      end

      it 'should translate string' do
        translator.result.should eq('Hallo Welt')
      end

      it 'should have ne errors' do
        translator.errors.should be_empty
      end
    end
  end
end
