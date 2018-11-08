# encoding: utf-8
# copyright: 2018, The Authors

title 'terraform validation'

control 'terraform' do
  impact 1
  title '**** Run terraform validation ****s'

  describe command('cd terraform/stage; terraform validate -var-file=terraform.tfvars.example') do
    its('exit_status') { should eq 0 }
  end

  describe command('cd ../prod; terraform validate -var-file=terraform.tfvars.example') do
    its('exit_status') { should eq 0 }
  end

end

