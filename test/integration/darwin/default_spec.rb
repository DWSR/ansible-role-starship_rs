# GitHub hosted runner user
user = 'runner'
user_dir = "/Users/#{user}"

# http://inspec.io/docs/reference/resources/directory/
describe directory("#{user_dir}/.config") do
  it { should exist }
end

# http://inspec.io/docs/reference/resources/command/
describe command('brew list starship') do
  its('stdout') { should match %r{bin\/starship} }
  its('stderr') { should_not match %r{Error} }
  its('exit_status') { should eq 0 }
end

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.profile.d/99_starship") do
  it { should exist }
  it { should_not be_more_permissive_than('0600') }
  its('owner') { should eq user }
  its('content') { should match %r{# Managed by Ansible} }
  its('content') { should match %r{eval "\$\(starship init zsh\)"} }
end

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.config/starship.toml") do
  it { should exist }
  its('owner') { should eq user }
  its('content') { should match %r{\[time\]} }
end
