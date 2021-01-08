terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      //version = "0.2.9"
    }
  }
}

provider "databricks" {
  azure_workspace_resource_id = var.workspaceid ##azurerm_databricks_workspace.ws1.id
}

data "databricks_node_type" "smallest" {
  local_disk = true
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = var.autotermination_minutes

  autoscale {
    min_workers = 1
    max_workers = 4
  }
}