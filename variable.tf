variable "tfc_gcp_dynamic_credentials" {
  description = "Object containing GCP dynamic credentials configuration"
  type = object({
    default = object({
      credentials = string
    })
    aliases = map(object({
      credentials = string
    }))
  })
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "postgres_tung_user_password" {
  type = string
}
  