require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'releases working bikes' do
    bike = Bike.new
    subject.dock(bike)
    bike = subject.release_bike
    expect(bike).to be_working
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  it 'docks something' do
    bike = Bike.new
    expect(subject.dock(bike)).to eq [bike]
    end

  describe '#release_bike' do
    it "releases a bike" do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it "raises an error when there are no bikes available" do
      expect { subject.release_bike }.to raise_error "No bikes available"
    end
  end

  describe '#dock' do
    it "does not accept a bike if over than station capacity" do
      subject.capacity.times { subject.dock Bike.new }
      expect { subject.dock Bike.new }.to raise_error "Sorry, the dock is full"
    end
  end

  describe "initialization" do
    subject { DockingStation.new }
    let(:bike) { Bike.new }
      it "defaults capacity" do
        described_class::DEFAULT_CAPACITY.times do
      subject.dock(bike)
    end
      expect{ subject.dock(bike) }.to raise_error "Sorry, the dock is full"
    end
  end
end
