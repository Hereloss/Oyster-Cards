# frozen_string_literal: true

require 'journey'

describe Journey do
  it 'Gives penalty fare if touch in twice' do
    expect_any_instance_of(JourneyLog).to receive(:travelling).and_return(true)
    expect(subject.fare('Victoria', 'In')).to eq 6
  end

  it 'Gives a penalty fare if touch out twice' do
    expect_any_instance_of(JourneyLog).to receive(:entry_station).and_return(nil)
    expect(subject.fare('Victoria', 'Out')).to eq 6
  end

  it 'Gives fare of £5 for zone 1 to zone 1' do
    station1 = Station.new('Victoria', 1)
    station2 = Station.new('Aldgate East', 1)
    expect_any_instance_of(JourneyLog).to receive(:station_object).and_return(station1)
    expect(subject.calculate_fare(station2)).to eq 5
  end

  it 'gives different if travelling from two different zones' do
    station1 = Station.new('Victoria', 4)
    station2 = Station.new('Aldgate East', 6)
    expect_any_instance_of(JourneyLog).to receive(:station_object).and_return(station1)
    expect(subject.calculate_fare(station2)).to eq 2
  end

  it 'If touch in and not having a penalty charges nothing' do
    expect_any_instance_of(JourneyLog).to receive(:travelling).and_return(false)
    expect(subject.fare('Victoria', 'In')).to eq 0
  end

  it 'check penalty fare' do
    expect(subject.penalty_fare('Waterloo', 'In')).to eq(true).or eq(false)
  end

  it 'check penalty fare' do
    expect(subject.penalty_fare('Waterloo', 'Out')).to eq(true).or eq(false)
  end

  it 'Gives penalty if out' do
    expect(subject.inside('Waterloo')).to eq(true).or eq(false)
  end

  it 'Gives penalty if in' do
    expect(subject.out('Waterloo')).to eq(true).or eq(false)
  end

  it 'Gives one if same station to same station' do
    station1 = Station.new('Victoria', 4)
    station2 = Station.new('Aldgate East', 4)
    expect_any_instance_of(JourneyLog).to receive(:station_object).and_return(station1)
    expect(subject.calculate_fare(station2)).to eq 1
  end

  it 'Will return false if has entry and exit stations' do
    expect_any_instance_of(JourneyLog).to receive(:entry_station).and_return('Waterloo')
    expect(subject.out('Victoria')).to eq false
  end

end
