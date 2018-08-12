require 'spec_helper'
require './lib/game'
require './lib/robot'
require './lib/tabletop'

describe Game do
  let(:robot) { Robot.new }
  let(:tabletop) { Tabletop.new(5, 5) }

  subject { described_class.new(robot, tabletop) }

  describe '#exec_command' do
    context 'when command is invalid' do
      it 'raises an error' do
        expect { subject.exec_command 'RUN' }.
          to raise_error Game::InvalidCommandError
      end
    end

    context 'when first command is PLACE' do
      before { subject.exec_command 'PLACE 1,2,NORTH' }

      it 'places robot at defined position' do
        expect(robot.x).to eq 1
        expect(robot.y).to eq 2
        expect(robot.direction).to eq 'NORTH'
      end
    end

    context 'when first command is not PLACE' do
      it 'raises error' do
        expect { subject.exec_command('MOVE') }.
          to raise_error Game::InvalidFirstCommandError
      end
    end

    context 'when command is MOVE' do
      before do
        subject.exec_command 'PLACE 1,2,NORTH'
        subject.exec_command 'MOVE'
      end

      it 'changes y position by 1' do
        expect(robot.y).to eq 3
      end
    end

    context 'when command is LEFT' do
      before do
        subject.exec_command 'PLACE 1,2,NORTH'
        subject.exec_command 'LEFT'
      end

      it 'changes orientation of robot by 90 deg counterclockwise' do
        expect(robot.direction).to eq 'WEST'
      end
    end

    context 'when command is RIGHT' do
      before do
        subject.exec_command 'PLACE 1,2,NORTH'
        subject.exec_command 'RIGHT'
      end

      it 'changes orientation of robot by 90 deg clockwise' do
        expect(robot.direction).to eq 'EAST'
      end
    end

    context 'when command is REPORT' do
      before do
        subject.exec_command 'PLACE 1,2,NORTH'
      end

      it 'outputs position of robot' do
        expect { subject.exec_command 'REPORT' }.
          to output('1,2,NORTH').to_stdout
      end
    end
  end
end
