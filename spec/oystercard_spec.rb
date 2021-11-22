require 'oystercard'

describe Oystercard do

  it "When initialized, has a balance" do
    expect(subject.balance).not_to be_nil
  end

  context "Oystercard top up" do

    it "Can be topped up" do
      expect(subject).to respond_to :top_up
    end

    it "Once topped up, has a higher balance" do
      old_balance = subject.balance
      subject.top_up
      expect(subject.balance).to be > old_balance
    end

    it "You can top up differing amounts" do
      expect{subject.top_up(10)}.not_to raise_error()
    end

    it "The top up value is added to the balance" do
      old_balance = subject.balance
      subject.top_up(5)
      expect(subject.balance).to eq(old_balance + 5)
    end

    it "The default limit of a card is £90" do
      expect(subject.limit).to eq 90
    end

    it "If a top up will make the balance exceed £90, will raise an error" do
      expect{subject.top_up(90.1)}.to raise_error("This exceeds your limit of £#{subject.limit}")
    end

  end

end