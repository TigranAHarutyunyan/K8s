variable "rg-name" {
  type        = string
  description = "Name of Resouce group"
}
variable "acr-name" {
  type        = string
  description = "Name of Azure Container registery"
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
}
