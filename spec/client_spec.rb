# encoding: utf-8
require 'spec_helper'

describe C3po do
  it 'should be true' do
    defined?(C3po).should be_true
  end

  describe 'Request' do
    context 'Google adapter' do

      before do
        C3po.configure do |config|
          config.provider = :google
          config.google_api_key = 'MYAPIKEY'
        end
      end

      describe 'request' do
        let(:translator) {C3po.new('to be translated')}
        let(:json_response) {File.open(file_path('multiple.json')).read}
        let(:query) {{:key=>"MYAPIKEY", :q=>"to be translated", :source=>"fr", :target=>"en"}}

        before do
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

    context 'Bing adapter' do

      before do
        C3po.configure do |config|
          config.provider = :bing
          config.bing_api_key = 'MYAPIKEY'
        end
      end

      describe 'request' do
        let(:translator) {C3po.new('to be translated')}
        let(:xml_response) {File.open(file_path('bing.xml')).read}
        let(:bing_query) {{:appId=>"MYAPIKEY", :text=>"to be translated", :from=>"fr", :to=>"en"}}

        before do
          C3po.configure do |config|
            config.provider = :bing
            config.bing_api_key = 'MYAPIKEY'
          end
          request_helper(translator, bing_query, xml_response)
          translator.translate(:fr, :en)
        end

        it 'should translate string' do
          translator.result.should eq("J'aime le café")
        end

        it 'should have ne errors' do
          translator.errors.should be_empty
        end
      end
    end
  end
end
