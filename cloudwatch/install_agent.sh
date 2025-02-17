# if use Amazon Linux 2023:

sudo yum install -y rsyslog

sudo systemctl enable rsyslog --now

#---#

sudo yum install -y amazon-cloudwatch-agent

sudo setfacl -m u:cwagent:rx /path/to/monitor # enable access in path to user cwagent

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard # generate config json

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json # start service with config json

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status # verify status


