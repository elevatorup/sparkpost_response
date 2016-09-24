require "spec_helper"
require "sparkpost_response/frameworks/rspec/helpers"

RSpec.describe "Configuration" do
  let!(:messages) { build(:sparkpost_results, :bounce) }
  before { stub_supply(:any, messages.to_json) }

  describe "config" do
    context "enabled" do
      before { SparkpostResponse.enabled = true }

      it "should return results for each instance" do
        expect(SparkpostResponse::MessageEvents.open_messages_event).to_not be_nil
        expect(SparkpostResponse::MessageEvents.bounce_messages_event).to_not be_nil
        expect(SparkpostResponse::MessageEvents.injection_messages_event).to_not be_nil
        expect(SparkpostResponse::MessageEvents.delivery_messages_event).to_not be_nil
      end
    end

    context "disabled" do
      before { SparkpostResponse.enabled = false }

      it "SparkpostResponse should have enabled, disabled" do
        expect(SparkpostResponse.enabled?).to eq(false)
      end

      it "should return no results for each instance" do
        expect(SparkpostResponse::MessageEvents.open_messages_event).to be_nil
        expect(SparkpostResponse::MessageEvents.bounce_messages_event).to be_nil
        expect(SparkpostResponse::MessageEvents.injection_messages_event).to be_nil
        expect(SparkpostResponse::MessageEvents.delivery_messages_event).to be_nil
      end
    end
  end
end
