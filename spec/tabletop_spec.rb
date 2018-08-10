require 'spec_helper'
require './lib/tabletop'

describe Tabletop do
  subject { described_class.new(10, 5) }

  describe '#point_inside?' do
    cases = [
      {in: [0, 0], out: true},
      {in: [3, 3], out: true},
      {in: [10, 1], out: false},
      {in: [1, 5], out: false},
      {in: [-1, -1], out: false},
    ]

    cases.each do |test|

      context "when point is #{test[:in]}" do
        it "returns #{test[:out]}" do
          expect(subject.point_inside?(*test[:in])).to eq test[:out]
        end
      end

    end
  end

  describe '#point_outside?' do
    cases = [
      {in: [-1, -1], out: true},
      {in: [2, 2], out: false},
    ]

    cases.each do |test|

      context "when point is #{test[:in]}" do
        it "returns #{test[:out]}" do
          expect(subject.point_outside?(*test[:in])).to eq test[:out]
        end
      end

    end
  end
end
