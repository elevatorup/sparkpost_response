require "spec_helper"

module SparkpostResponse
  RSpec.describe MessageEvents do
    let!(:messages) { build(:sparkpost_results, :bounce) }
    before { stub_supply(:any, messages.to_json) }

    describe "{suffix}_event_messages" do
      context "suffix method calling" do
        it { expect(subject).to respond_to(:open_messages_event) }
        it { expect(subject).to respond_to(:bounce_messages_event) }
        it { expect(subject).to respond_to(:injection_messages_event) }
        it { expect(subject).to respond_to(:delivery_messages_event) }
      end

      context "suffix method calling with options" do
        it { expect(subject).to respond_to(:bounce_messages_event).with(2).argument }
      end

      context "A successful query" do
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

    describe "classify_bounces" do
      it "It should add an entry `classify_bounce` to the response" do
        response = subject.bounce_messages_event(classify_bounces: true)
        expect(response.first[:classify_bounce]).to_not eq(nil)
      end
    end
  end
end
