resource "null_resource" "run_script" {
  depends_on = [time_sleep.wait_for_ip]
  provisioner "local-exec" {
    command = "echo 'Hello JB class'"
  }
}
