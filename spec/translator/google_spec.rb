# encoding: utf-8
require 'spec_helper'

describe C3po::Translator::Google do
  let(:translator) { C3po.new('to be translated')}
  let(:json_response) {File.open(file_path('multiple.json')).read}
  let(:json_detect_response) {File.open(file_path('auto_detect.json')).read}

  before do
    C3po.configure do |config|
      config.provider = :google
      config.google_api_key = 'MYAPIKEY'
    end
  end

  it 'should build a query hash' do
    translator.adaptor.build_query(:fr, :en).should eq({:key=>"MYAPIKEY", :q=>"to be translated", :source=>'fr', :target=> 'en'})
  end

  it 'should build a query hash for detect method' do
    translator.adaptor.build_detect_query.should eq({:key=>"MYAPIKEY", :q=>"to be translated"})
  end

  it 'should read json response' do
    translator.adaptor.parse(json_response).should eq('Hallo Welt')
  end

  it 'should read json iauto_detect response' do
    translator.adaptor.parse(json_detect_response).should eq('en')
  end
end
