resource "google_iam_workload_identity_pool" "todo_tfc_identity_pool" {
  workload_identity_pool_id     = "terraform-pool-todo"
  display_name                  = "terraform-pool-todo"
  description                   = "Production Pool Todo"
  disabled                      = false
}  