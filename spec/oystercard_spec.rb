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

  context "Oystercard deduct" do

    it "expects response to deduct" do
      expect(subject).to respond_to :deduct
    end

    it "Balance will be lower if money deducted" do
      subject.top_up
      old_balance = subject.balance
      expect(subject.deduct).to be < old_balance
    end

    it "Money cannot be deducted if balance goes below 0" do
      expect{subject.deduct}.to raise_error "Not enough money"
    end

    it "Accepts argument for deducting balance" do
      subject.top_up(5)
      expect{ subject.deduct(5) }.to_not raise_error 
    end
  end

  context "Touch in / Touch out" do

    it "check if person in journey" do
      expect(subject.in_journey?).to eq(false).or eq(true)
    end
    
    it "expects response to touch in" do
      expect(subject).to respond_to :touch_in
    end

    it "sets in journey to true after touching in" do
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "expects response to touch out" do
      expect(subject).to respond_to :touch_out
    end 

    it "sets in journey to true after touching out" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end

end