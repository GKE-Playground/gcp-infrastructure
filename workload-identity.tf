module "my-app-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name                = "todo-sa"
  namespace           = kubernetes_namespace.todo_namespace.metadata[0].name
  project_id          = var.project_id
  roles               = ["roles/storage.admin", "roles/compute.admin","roles/cloudsql.client"]
}