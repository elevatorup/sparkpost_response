require "spec_helper"

module SparkpostResponse
  RSpec.describe MessageEvents do
    describe "{suffix}_event_messages" do
      context "suffix method calling" do
        before { allow_any_instance_of(MessageEvents).to receive(:attribute_messages_event).and_return(true) }

        it "should call the event_messages method based on suffix names" do
          expect(subject.open_messages_event).to eq(true)
          expect(subject.bounce_messages_event).to eq(true)
          expect(subject.injection_messages_event).to eq(true)
          expect(subject.delivery_messages_event).to eq(true)
        end
      end

      context "suffix method calling with options" do
        let(:options) { { reciver: "john@example.com" } }
        before { expect(subject).to receive(:attribute_messages_event).with("bounce", options).and_return(true) }

        it "should call the event_messages with options being passed" do
          expect(subject.bounce_messages_event(options)).to eq(true)
        end
      end

      context "A successful query" do
        before { stub_supply(:any, File.read("./fixtures/bounced_message.json")) }

        it "should return processed json results of bounced messages" do
          expect(subject.bounce_messages_event).to_not be_nil
        end
      end
    end

    describe "process_options" do
      let(:options) { { bounce_class: "1", recipients: ["john@example.com", "jane@example.com"] } }
      it "returns a list of hashed options in query format" do
        expected = "bounce_class=1&recipients=john@example.com,jane@example.com"
        expect(subject.process_options(options)).to eq(expected)
      end
    end
  end
end
