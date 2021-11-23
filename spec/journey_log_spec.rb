# frozen_string_literal: true

require 'journey_log'

describe JourneyLog do
  context 'station' do
    let(:station) { double :station }

    it 'Remembers the station it touched in at' do
      subject.journey_start(station)
      expect(subject.entry_station).to eq station
    end

    it 'Removes the station on touching out' do
      subject.journey_start(station)
      subject.journey_end(station)
      expect(subject.entry_station).to eq nil
    end

    it 'If not in a station, returns nil' do
      expect(subject.entry_station).to eq nil
    end
  end

  it 'stores journey' do
    subject.journey_start('Victoria')
    subject.store_journey('Waterloo')
    expect(subject.past_journeys.count).to_not eq 0
  end

  context 'Travel History' do
    it 'Adds start station to current journey' do
      subject.journey_start('Waterloo')
      expect(subject.current_journey['Waterloo']).to eq nil
    end

    it 'Adds exit station to current journey' do
      subject.journey_start('Waterloo')
      subject.journey_end('Victoria')
      expect(subject.past_journeys[0]['Waterloo']).to eq 'Victoria'
    end

    it 'Adds journey upon ending to list of past journeys' do
      subject.journey_start('Waterloo')
      subject.journey_end('Victoria')
      expect(subject.past_journeys).to include({ 'Waterloo' => 'Victoria' })
    end

    it 'Feature test: Has a list of all past journey' do
      subject.journey_start('Waterloo')
      subject.journey_end('Victoria')
      subject.journey_start('Charing Cross')
      subject.journey_end('Victoria')
      subject.journey_start('Waterloo')
      subject.journey_end('Edgeware')
      expect(subject.past_journeys).to include({ 'Waterloo' => 'Victoria' })
      expect(subject.past_journeys).to include({ 'Charing Cross' => 'Victoria' })
      expect(subject.past_journeys).to include({ 'Waterloo' => 'Edgeware' })
    end
  end

  it 'Can show past journeys' do
    expect(subject.journeys).to be_instance_of(Array)
  end
end
