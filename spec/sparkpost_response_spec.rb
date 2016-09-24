require "spec_helper"
require "sparkpost_response/frameworks/rspec"

describe SparkpostResponse do
  it "has a version number" do
    expect(SparkpostResponse::VERSION).not_to be nil
  end

  context "should turn sparkpost on in a `with_sparkpost` block" do
    it "should enable Sparkpost response" do
      expect(SparkpostResponse.enabled?).to eq(false)

      with_sparkpost { expect(SparkpostResponse.enabled?).to eq(true) }

      expect(SparkpostResponse.enabled?).to eq(false)
    end
  end
end
