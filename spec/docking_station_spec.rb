require 'docking_station'

describe DockingStation do
  let(:bike) { double :bike }

  it { is_expected.to respond_to :release_bike }

  it { is_expected.to respond_to(:dock).with(1).argument }

  describe '#release_bike' do
    it "releases a bike" do
      subject.dock(bike)
      allow(bike).to receive(:broken?).and_return(false)
      expect(subject.release_bike).to eq bike
    end

    it "raises an error when there are no bikes available" do
      expect { subject.release_bike }.to raise_error "No bikes available"
    end

    it 'releases working bikes' do
      bike = double(:bike, broken?: false)
      subject.dock(bike)
      allow(bike).to receive(:working?).and_return(true)
      expect(subject.release_bike).to be_working
    end

    it "does not release broken bikes" do
      bike = double(:bike, broken?: true)
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error "No working bikes available"
    end
  end

  describe '#dock' do
    it "does not accept a bike if over than station capacity" do
      subject.capacity.times { subject.dock(bike) }
      expect { subject.dock(bike) }.to raise_error "Sorry, the dock is full"
    end

    it 'docks something' do
      expect(subject.dock(bike)).to eq [bike]
    end

    it "docks broken bikes" do
      bike = double(:bike, broken?: true)
      expect(subject.dock(bike)).to eq [bike]
    end
  end

  describe "initialization" do
    subject { DockingStation.new }
    it "defaults capacity" do
      described_class::DEFAULT_CAPACITY.times do
      subject.dock(bike)
    end
      expect{ subject.dock(bike) }.to raise_error "Sorry, the dock is full"
    end
  end
end
