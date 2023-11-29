resource "aws_launch_template" "lt-ng1" {
  instance_type          = "t3.small"
  key_name               = "eks"
  name                   = format("at-lt-%s-ng1", aws_eks_cluster.cluster.name)
  tags                   = {}
  image_id               = data.aws_ssm_parameter.eksami.value
  vpc_security_group_ids = [aws_security_group.allnodes-sg.id]
  user_data              = base64encode(local.eks-node-private-userdata)
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = format("%s-ng1", aws_eks_cluster.cluster.name)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}