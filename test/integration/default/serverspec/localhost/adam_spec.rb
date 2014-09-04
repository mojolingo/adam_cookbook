require 'spec_helper'

describe 'Adam Snark Rabbit' do
  describe user('adam') do
    it { should exist }
    it { should belong_to_group 'adam' }
  end

  describe service('ejabberd') do
    it { should be_running }
  end

  describe service('mongodb') do
    it { should be_running }
  end

  describe service('adam-brain') do
    it { should be_running }
  end

  describe service('adam-memory') do
    it { should be_running }
  end

  describe port(5222) do
    it { should be_listening.with('tcp') }
  end
end
