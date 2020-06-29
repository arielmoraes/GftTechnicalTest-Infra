variable "environment" {
    type = string
}

variable "resource_counter" {
    type = number
}

variable "aks_serviceprincipal" {
    type = map 
    default = {
        "client_id" = ""
        "client_secret" = ""
    }
}

variable "tags" {
    type = map
}

