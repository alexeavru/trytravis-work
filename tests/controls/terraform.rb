# encoding: utf-8
# copyright: 2018, The Authors

title 'terraform validation'

control 'terraform' do
  impact 1
  title '**** Run terraform validation ****'

  describe command('terraform validate -check-variables=false terraform/stage') do
    its('exit_status') { should eq 0 }
  end

end

