# encoding: utf-8
# copyright: 2018, The Authors

title 'terraform validation'

control 'terraform' do
  impact 1
  title '**** Run terraform validation ****'

  describe command('rm $ROOT_PROJECT/terraform/stage/backend.tf') do
    its('exit_status') { should eq 0 }
  end

  describe command('rm $ROOT_PROJECT/terraform/prod/backend.tf') do
    its('exit_status') { should eq 0 }
  end

  describe command('teraform init -var-file=terraform/stage/terraform.tfvars.example terraform/stage') do
    its('exit_status') { should eq 0 }
  end

  describe command('terraform validate -check-variables=false terraform/stage') do
    its('exit_status') { should eq 0 }
  end

  describe command('terraform validate -check-variables=false terraform/prod') do
    its('exit_status') { should eq 0 }
  end

  describe command('cd $ROOT_PROJECT/terraform/stage') do
    its('exit_status') { should eq 0 }
  end

  describe command('tflint') do
    its('exit_status') { should eq 0 }
  end

  describe command('cd $ROOT_PROJECT/terraform/prod') do
    its('exit_status') { should eq 0 }
  end

  describe command('tflint') do
    its('exit_status') { should eq 0 }
  end


