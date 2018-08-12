require 'spec_helper'
require './lib/robot'

describe Robot do
  subject { described_class.new }

  describe '#place' do
    context 'when placed at 1, 2, NORTH' do
      before { subject.place(1, 2, 'NORTH') }
      it { expect(subject.x).to eq 1 }
      it { expect(subject.y).to eq 2 }
      it { expect(subject.direction).to eq 'NORTH' }
    end

    context 'when placed at unknown direction' do
      it { expect { subject.place(0, 0, 'SOME_DIRECTION') }.
        to raise_error Robot::UndefinedDirectionError }
    end
  end

  describe '#left' do
    context 'when current direction is NORTH' do
      before do
        subject.place(0, 0, 'NORTH')
        subject.left
      end

      it 'rotates the robot 90 degrees counterclockwise' do
        expect(subject.direction).to eq 'WEST'
      end
    end

    context 'when we call method 4 times' do
      before do
        subject.place(0, 0, 'SOUTH')
        4.times { subject.left }
      end

      it 'looks in the same direction' do
        expect(subject.direction).to eq 'SOUTH'
      end
    end
  end

  describe '#right' do
    context 'when current direction is NORTH' do
      before do
        subject.place(0, 0, 'NORTH')
        subject.right
      end

      it 'rotates the robot 90 degrees clockwise' do
        expect(subject.direction).to eq 'EAST'
      end
    end

    context 'when we call method 4 times' do
      before do
        subject.place(0, 0, 'SOUTH')
        4.times { subject.right }
      end

      it 'looks in the same direction' do
        expect(subject.direction).to eq 'SOUTH'
      end
    end
  end

  describe '#move' do
    let(:x) { 2 }
    let(:y) { 3 }

    context 'when direction is NORTH' do
      
      before do
        subject.place(x, y, 'NORTH')
        subject.move
      end

      it 'increases y by 1' do
        expect(subject.y).to eq (y + 1)
      end

      context 'and wnen we call method twice' do
        before { subject.move }

        it 'increases y by 2' do
          expect(subject.y).to eq (y + 2)
        end
      end
    end

    context 'when direction is SOUTH' do
      before do
        subject.place(x, y, 'SOUTH')
        subject.move
      end

      it 'decreases y by 1' do
        expect(subject.y).to eq (y - 1)
      end
    end

    context 'when direction is WEST' do
      before do
        subject.place(x, y, 'WEST')
        subject.move
      end

      it 'decreases x by 1' do
        expect(subject.x).to eq (x - 1)
      end
    end

    context 'when direction is EAST' do
      before do
        subject.place(x, y, 'EAST')
        subject.move
      end

      it 'increases x by 1' do
        expect(subject.x).to eq (x + 1)
      end
    end
  end

  describe '#report' do
    before do
      subject.place(2, 3, 'NORTH')
    end

    it 'returns array with current robot position' do
      expect(subject.report).to eq [2, 3, 'NORTH']
    end
  end

  describe '#direction_valid?' do
    xit 'implement' do

    end
  end
end
