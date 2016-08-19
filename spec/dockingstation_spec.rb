require 'dockingstation'

describe DockingStation do

  let(:bike) { double :bike }

  # it {expect(subject).to respond_to(:release_bike)}
  # it {expect(subject).to respond_to(:dock_bike).with(1).argument}

  it "docks something" do
    #We want to return the bike we dock
    expect(subject.dock_bike(bike)).to include bike #change eq to include? bike
  end

  it "if docking station is empty, raise an error" do
    expect{subject.release_bike}.to raise_error("no bikes")
  end
#currently tests anytime relseasing a bike an error is raised. if too many bikes are taken, report back empty.
  #so dock cannot be full but can be empty

  it "only allows docking up to a certain capacity then throws full error" do
    (subject.capacity).times {subject.dock_bike(bike)}
    expect {subject.dock_bike(bike)}.to raise_error("full!")
  end

  #test initializing DockingStation with capacity argument
  it "when given no argument, docking station equals default capacity" do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it "when given an argument to docking station, capacity equals that argument" do
    station = DockingStation.new(3)
    expect(station.capacity).to eq 3
  end

  it "docking stations accepts broken bike" do #working bikes can already be docked (tested above)
    allow(bike).to receive(:report_broken) { false }
    expect(subject.dock_bike(bike)).to include bike
  end

  it "should release a working bike" do
    allow(bike).to receive(:working?) { true }
    subject.dock_bike(bike)
    expect(subject.release_bike).to be_empty
  end

  it "docking stations do not release broken bikes" do
    allow(bike).to receive(:working?) { false }
    subject.dock_bike(bike)
    expect{subject.release_bike}.to raise_error("broken bike")
  end

  it "check if there are broken bikes docked in docking station and group them in an array" do
    bike1 = Bike.new
    bike2 = Bike.new
    bike1.report_broken
    bike2.report_broken
    expect((subject.bikes).group_broken).to include(bike1, bike2)
  end

end
