# Step 10 - Add output variables
output "DevInstance" {
  value = aws_instance.dev_VM.public_ip
}