# encoding: utf-8
# copyright: 2018, The Authors

title 'ansible validation'

control 'ansible' do
  impact 1
  title 'Run ansible validation'

  describe command('ansible-lint -v ansible/playbooks/*.yml') do
    its('exit_status') { should eq 0 }
  end

end

