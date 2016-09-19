require "spec_helper"

module SparkpostResponse
  RSpec.describe MessageEvents do
    let!(:message_event) { MessageEvents.new }

    describe "bounced_event_messages" do
      context "A Sucessfull query" do
        before { stub_supply(:any, File.read("./fixtures/bounced_message.json")) }

        it "should return processed json results of bounced messages" do
          response = message_event.bounced_event_messages
          expect(response).to_not be_nil
        end
      end
    end

    describe "process_options" do
      let(:options) { { bounce_class: "1", recipients: ["john@example.com", "jane@example.com"] } }
      it "returns a list of hashed options in query format" do
        expected = "bounce_class=1&recipients=john@example.com,jane@example.com"
        expect(message_event.process_options(options)).to eq(expected)
      end
    end
  end
end
