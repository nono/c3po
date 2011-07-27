# encoding: utf-8
require 'spec_helper'

describe C3po::Translator::Bing do
  let(:translator) { C3po.new('to be translated')}
  let(:xml_response) {File.open(file_path('bing.xml')).read}

  before do
    C3po.configure do |config|
      config.provider = :bing
      config.bing_api_key = 'BINGAPIKEY'
    end
  end

  it 'should build a query hash' do
    translator.build_query(:fr, :en).should eq({:appId=>"BINGAPIKEY", :text=>"to be translated", :from=>'fr', :to=> 'en'})
  end

  it 'should read xml response' do
    translator.parse(xml_response).should eq("J'aime le café")
  end
end

