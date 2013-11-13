require 'spec_helper'

describe 'Adam Snark Rabbit' do
  describe user('adam') do
    it { should exist }
    it { should belong_to_group 'adam' }
  end
end
