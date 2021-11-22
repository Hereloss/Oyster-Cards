require 'station'

describe Station do

  context "About itself" do
    subject { Station.new("Waterloo", 1) }

    it "Knows it name" do
      expect(subject).to respond_to :name
    end

    it "Displays correct name" do
      expect(subject.name).to eq "Waterloo"
    end

    it "knows its zone" do
      expect(subject).to respond_to :zone
    end

    it "Displays correct zone" do
      expect(subject.zone).to eq 1
    end
  end
end