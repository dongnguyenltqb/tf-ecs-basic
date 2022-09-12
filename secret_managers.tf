// Secret
resource "aws_secretsmanager_secret" "app" {
  name = format("%s%sAppSecret", var.cluster_name, var.be_service_name)
}

resource "aws_secretsmanager_secret_version" "version" {
  version_stages = ["v1.0.1"]
  secret_id      = aws_secretsmanager_secret.app.id
  secret_string  = jsonencode(var.secrets)
}
