# encoding: utf-8
require 'spec_helper'

describe C3po::Translator::Configuration do

  context 'with several providers' do

    before do
      C3po.configure do |config|
        config.provider = [:google, :bing]
        config.google_api_key = 'MYAPIKEY'
      end
      C3po::Translator::Configuration.provider.should_receive(:sample).and_return(:google)
      C3po.new('to be translated')
    end

    it 'should have a provider method' do
      C3po::Translator::Configuration.provider.should eq([:google, :bing])
    end

  end

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
