# encoding: utf-8
require 'spec_helper'

describe C3po do
  describe C3po::NoGivenString do

    before do
      C3po.configure do |config|
        config.provider = :google
        config.google_api_key = 'MYAPIKEY'
      end
    end

    it 'should raise a exception' do
      lambda {C3po.new}.should raise_error C3po::NoGivenString
    end

  end

  describe C3po::NoGivenProvider do

    context 'when provider is nil' do

      before do
        C3po.configure do |config|
          config.provider = nil
          config.google_api_key = 'MYAPIKEY'
        end
      end

      it 'should raise a exception' do
        lambda {C3po.new('text')}.should raise_error C3po::NoGivenProvider
      end

    end

    context 'when provider is not registered' do

      before do
        C3po.configure do |config|
          config.provider = :af83
          config.google_api_key = 'MYAPIKEY'
        end
      end

      it 'should raise a exception' do
        lambda {C3po.new('text')}.should raise_error C3po::NoGivenProvider
      end

    end

  end

  describe 'with Google adapter' do

    before do
      C3po.configure do |config|
        config.provider = :google
        config.google_api_key = 'MYAPIKEY'
      end
    end

    describe 'requesting language list' do
      let(:uri) {'https://www.googleapis.com/language/translate/v2/languages'}
      let(:query) {{:key=>"MYAPIKEY"}}
      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('languages.json')).read}

      before do
        request_helper(uri, query, json_response)
        translator.languages
      end

      it 'should return an array of country code' do
        translator.result.languages.should eq(["af", "zh-TW"])
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end

    describe 'requesting a translation' do
      let(:uri) {'https://www.googleapis.com/language/translate/v2'}
      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('multiple.json')).read}
      let(:query) {{:key=>"MYAPIKEY", :q=>"to be translated", :source=>"fr", :target=>"en"}}

      before do
        request_helper(uri, query, json_response)
        translator.translate(:fr, :en)
      end

      it 'should return a translate string' do
        translator.result.translation.should eq('Hallo Welt')
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end

    describe 'requesting a detection' do
      let(:uri) {'https://www.googleapis.com/language/translate/v2/detect'}
      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('auto_detect.json')).read}
      let(:query) {{:key=>"MYAPIKEY", :q=>"to be translated"}}

      before do
        request_helper(uri, query, json_response)
        translator.is
      end

      it 'should return a country code' do
        translator.result.language.should eq('en')
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end

    describe 'requesting a detection matcher' do
      let(:uri) {'https://www.googleapis.com/language/translate/v2/detect'}
      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('auto_detect.json')).read}
      let(:query) {{:key=>"MYAPIKEY", :q=>"to be translated"}}

      before do
        request_helper(uri, query, json_response)
      end

      it 'should return true for :en' do
        translator.is?(:en).should be_true
      end

      it 'should return false for :fr' do
        translator.is?(:fr).should be_false
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end
  end

  describe 'with Bing adapter' do

    before do
      C3po.configure do |config|
        config.provider = :bing
        config.bing_api_key = 'MYAPIKEY'
      end
    end

    describe 'requesting a translation' do
      let(:uri) {'http://api.microsofttranslator.com/V2/Http.svc/Translate'}
      let(:translator) {C3po.new('to be translated')}
      let(:xml_response) {File.open(file_path('bing.xml')).read}
      let(:bing_query) {{:appId=>"MYAPIKEY", :text=>"to be translated", :from=>"fr", :to=>"en"}}

      before do
        request_helper(uri, bing_query, xml_response)
        translator.translate(:fr, :en)
      end

      it 'should return a translated string' do
        translator.result.translation.should eq("J'aime le café")
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end

    describe 'requesting a detection' do
      let(:uri) {'http://api.microsofttranslator.com/V2/Http.svc/Detect'}
      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('auto_detect.xml')).read}
      let(:query) {{:appId=>"MYAPIKEY", :text=>"to be translated"}}

      before do
        request_helper(uri, query, json_response)
        translator.is
      end

      it 'should return a country code' do
        translator.result.language.should eq('en')
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end

    describe 'requesting a detection matcher' do
      let(:uri) {'http://api.microsofttranslator.com/V2/Http.svc/Detect'}
      let(:translator) {C3po.new('to be translated')}
      let(:json_response) {File.open(file_path('auto_detect.xml')).read}
      let(:query) {{:appId=>"MYAPIKEY", :text=>"to be translated"}}

      before do
        request_helper(uri, query, json_response)
      end

      it 'should return true for :en' do
        translator.is?(:en).should be_true
      end

      it 'should return false for :fr' do
        translator.is?(:fr).should be_false
      end

      it 'should have no errors' do
        translator.errors.should be_empty
      end
    end
  end
end
