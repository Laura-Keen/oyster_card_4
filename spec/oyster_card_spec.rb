require 'oystercard'

describe OysterCard do
 test_value = 50

 before(:each) do
     @oystercard = OysterCard.new
   end

 describe '#top_up' do



  it "has a default balance of 0 when initialized" do
    expect(@oystercard.balance).to eq(0)
  end
 it "tops up with the top up value as the argument" do
   @oystercard.top_up(test_value)
   expect(@oystercard.balance).to eq test_value
 end
 it "raises an error when top up value exceeds maximum value" do
   @limit = OysterCard::MAXBALANCE
   @single_journey = OysterCard::SINGLE_JOURNEY
   @oystercard.top_up(@single_journey)
   expect { @oystercard.top_up(@limit) }.to raise_error "Your balance cannot be over £90"
 end
end

describe '#deduct' do

 it "deducts money from balance when you spend money" do
   @oystercard.top_up(test_value)
   @oystercard.deduct(test_value)
   expect(@oystercard.balance).to eq 0
 end
 it "deducts money of journey after journey completion" do
  @oystercard.top_up(1)
  @oystercard.touch_in
  @oystercard.touch_out
  expect(@oystercard.balance).to eq 0
  end
end

describe '#touch_in' do
  it "says you're in a journey when you touch in but don't touch out" do
  @oystercard.top_up(1)
  @oystercard.touch_in
  expect(@oystercard.in_journey?).to eq true
  end

  it"raises an error if there isn't enough balance for single journey" do
    expect{ @oystercard.touch_in }.to raise_error 'Not enough balance'
  end
end

describe '#touch_out' do
  it "says you are not in a journey after touching in and touching out" do
    @oystercard.top_up(1)
    @oystercard.touch_in
    @oystercard.touch_out
    expect(@oystercard.in_journey?).to eq false
  end
end

end
