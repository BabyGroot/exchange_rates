require "rails_helper"

RSpec.describe Api::ExchangeRates::AdapterFactory do
  context ".new" do
    let(:default_client) { 'fixer.io' }
    let(:fixer_client)   { Api::ExchangeRates::Adapters::FixerIoAdapter }
    let(:base_client)    { Api::ExchangeRates::Adapters::BaseAdapter }

    describe 'with no parameter' do
      it "defaults with preferred client fixer.io" do
        factory = Api::ExchangeRates::AdapterFactory.new
        expect(factory.preferred_client).to eq(default_client)
        expect(factory.client).to eq(fixer_client)
      end
    end

    describe 'with given a parameter' do
      let(:dummy_client) { 'some_client' }

      it "defaults to the base client" do
        factory = Api::ExchangeRates::AdapterFactory.new(dummy_client)
        expect(factory.preferred_client).to eq(dummy_client)
        expect(factory.client).to eq(base_client)
      end
    end
  end
end
