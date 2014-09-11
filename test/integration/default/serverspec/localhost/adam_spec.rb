require 'spec_helper'

describe 'Adam Snark Rabbit' do
  describe service('adam_xmpp_server') do
    it { should be_running }
  end

  describe service('mongodb') do
    it { should be_running }
  end

  describe service('adam-snark-rabbit-basic-brain') do
    it { should be_running }
  end

  describe service('adam-snark-rabbit-basic-memory') do
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening.with('tcp') }
  end
end
