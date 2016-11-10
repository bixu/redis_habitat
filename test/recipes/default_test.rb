# # encoding: utf-8

# Inspec test for recipe redis_habitat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

unless os.windows?
  describe user('root') do
    it { should exist }
  end
end

describe port(6379) do
  it { should be_listening }
end

describe command('hab pkg exec core/redis redis-cli ping') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match('PONG') }
end

describe command('hab --version') do
  its('exit_status') { should eq 0 }
end
