require 'spec_helper'
require './lib/game'

describe Game do
  describe '#run' do
    it { expect(described_class.new.run).to eq 1 }
  end
end
