user = 'kitchen'
user_dir = "/home/#{user}"

# http://inspec.io/docs/reference/resources/directory/
describe directory("#{user_dir}/.config") do
  it { should exist }
end

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.local/bin/starship") do
  it { should exist }
  it { should_not be_more_permissive_than('0755') }
  it { should be_executable.by('owner') }
  # Larger than 1MB
  its('size') { should > 1048576 }
  its('owner') { should eq user }
  its('group') { should eq user }
end

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.profile.d/99_starship") do
  it { should exist }
  it { should_not be_more_permissive_than('0600') }
  its('owner') { should eq user }
  its('group') { should eq user }
  its('content') { should match %r{# Managed by Ansible} }
  its('content') { should match %r{eval "\$\(starship init bash\)"} }
end

# http://inspec.io/docs/reference/resources/file/
describe file("#{user_dir}/.config/starship.toml") do
  it { should exist }
  its('owner') { should eq user }
  its('group') { should eq user }
  its('content') { should match %r{\[time\]} }
end
