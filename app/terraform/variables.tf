variable "name-pattern" {
  type        = string
  description = "Name Pattern of resources"
}
variable "location" {
  type        = string
  description = "Location"
}
variable "context_path" {
  type        = string
  description = "Path to the Source code "
}
variable "context_access_token" {
  type        = string
  description = "PAT of gitHub"
  sensitive   = true
}
