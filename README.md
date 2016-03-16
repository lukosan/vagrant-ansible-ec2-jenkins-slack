# vagrant-ansible-ec2-jenkins-slack

In order for this to run you need to:

  - Download and Install [Vagrant](https://www.vagrantup.com/downloads.html) or run: `$ brew install Caskroom/cask/vagrant`
  - Install [Ansible](http://docs.ansible.com/intro_installation.html) or run: `$ brew install ansible`
  - Install python and boto so that the ec2.py script will run when called by ansible
  - Install the vagrant-aws plugin with: `$ vagrant plugin install vagrant-aws`
  - Register a dummy box: `vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box`
  
## Jenkins

You will need to edit the file jenkins/Vagrantfile and put settings specific to your EC2 configuration.

Specifically the following lines are important:

```ruby
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']			# you can hard code your access key and secret...
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']	# ... but it's not a great idea
    
    aws.keypair_name = "awsroot" 							# <-- change to your ec2 key pair name...
    override.ssh.private_key_path = "../awsroot.pem" 		# ...and then put your key in this file
    
    aws.security_groups = ["my-security-group"] 			# <-- change to your ec2 security group name
     
    aws.region = "eu-west-1"								# AWS region Ireland
    aws.ami = "ami-a10897d6" 								# this AMI is for eu-west-1 (Ireland)
```

You can see from the script above that you need to put your EC2 SSH key into a file called `awsroot.pem` in this folder.

I keep my AWS access key and secret in a file called `aws.credentials` in this folder that looks like this:

```
export AWS_ACCESS_KEY_ID="XxxxxxxxxxxxxxxxxxxxX"
export AWS_SECRET_ACCESS_KEY="XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX"
```

so that when I run `bash jenkins-ec2-up.sh` it will `source` the `aws.credentials` file and set them as environment variables before the `vagrant up` command is called. 