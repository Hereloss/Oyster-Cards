require 'oystercard'

describe Oystercard do

  context "Oystercard balance" do

    # before do
    #   @oystercard = Oystercard.new
    # end

    it "When initialized, has a balance" do
      expect(subject.balance).not_to be_nil
    end

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

  end

end