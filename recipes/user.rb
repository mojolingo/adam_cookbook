user "adam" do
  system true
  comment "Adam User"
  home "/home/adam"
  supports :manage_home => true
end

group 'adam' do
  members ['adam', 'vagrant']
end
