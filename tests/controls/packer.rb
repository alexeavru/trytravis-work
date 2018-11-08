# encoding: utf-8
# copyright: 2018, The Authors

title 'packer validation'

control 'packer' do
  impact 1
  title '**** Run packer validation ****'

  describe command('packer validate -var-file=packer/variables.json.example packer/app.json') do
    its('stdout') { should eq "Template validated successfully.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command('packer validate -var-file=packer/variables.json.example packer/db.json') do
    its('stdout') { should eq "Template validated successfully.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command('packer validate -var-file=packer/variables.json.example packer/immutable.json') do
    its('stdout') { should eq "Template validated successfully.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command('packer validate -var-file=packer/variables.json.example packer/ubuntu16.json') do
    its('stdout') { should eq "Template validated successfully.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

end
