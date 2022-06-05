# Find machine image
data "aws_ami" "ubuntu-lts" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "name"
    values = ["my_jenkins"]
  }
}
# data.aws_ami.ubuntu-lts.image_id
# Launch configuration
# Configures the machines that are deployed
#
resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = var.launch-config-name
  image_id                    = data.aws_ami.ubuntu-lts.image_id
  instance_type               = var.instance-type
  iam_instance_profile        = var.iam-role-name != "" ? var.iam-role-name : ""
  key_name                    = var.instance-key-name != "" ? var.instance-key-name : ""
  user_data                   = var.user-data-script != "" ? file("${var.user-data-script}") : ""
  associate_public_ip_address = var.instance-associate-public-ip == "true" ? true : false
  security_groups             = ["${aws_security_group.sg.id}"]
}
data "aws_ebs_volume" "ebs_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "tag:Name"
    values = ["BACKUP"]
  }
}


# AutoScaling Group
# Scale (up/down) the number of machines, based on some criteria
#
resource "aws_autoscaling_group" "asg" {
  # name                      = "${var.asg-name}"
  name                      = aws_launch_configuration.launch_config.name
  min_size                  = var.asg-min-size
  desired_capacity          = var.asg-def-size
  max_size                  = var.asg-max-size
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = ["${aws_subnet.subnet-1.id}"]
  target_group_arns         = ["${aws_lb_target_group.lb_target.arn}"]
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  min_elb_capacity          = var.asg-min-size

  lifecycle {
    create_before_destroy = true
  }

  tags = concat(
    local.common_tags_asg,
    tolist([
      tomap({
        "key"                 = "Name"
        "value"               = "${var.instance-tag-name}"
        "propagate_at_launch" = true
      })
    ])
  )
}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_autoscaling_group.asg]

  destroy_duration = "60s"
}

data "aws_instances" "test" {
  instance_tags = {
    Name = "Testing-EC2-Terraform"
  }
  instance_state_names = ["running"]

  depends_on = [time_sleep.wait_60_seconds]
}


resource "aws_volume_attachment" "ebs_backup" {
    device_name  = "/dev/sdf"
    volume_id    = "${data.aws_ebs_volume.ebs_volume.id}"
    instance_id  = join("\n", data.aws_instances.test.ids)
    force_detach = "false"
    skip_destroy = "true"
    depends_on    = [data.aws_instances.test]
}