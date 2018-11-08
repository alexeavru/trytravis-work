# encoding: utf-8
# copyright: 2018, The Authors

title 'terraform validation'

control 'terraform' do
  impact 1
  title '**** Run terraform validation ****'

  describe command('terraform validate -var-file=terraform/stage/terraform.tfvars.example terraform/stage') do
    its('stdout') { should eq "" }
    its('exit_status') { should eq 0 }
  end

end

