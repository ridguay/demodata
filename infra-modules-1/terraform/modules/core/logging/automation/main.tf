
resource "azurerm_automation_module" "threadjob" {
  name                    = "ThreadJob"
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  module_link {
    uri = "https://www.powershellgallery.com/api/v2/package/ThreadJob/2.0.3"
  }

}

resource "azurerm_automation_runbook" "updatemanagement-turnoffvms" {
  name                    = "UpdateManagement-TurnOffVms"
  location                = var.location
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
  automation_account_name = var.automation_account_name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Runbook to TurnOff Virtual Machines after Windows Updates have been installed"
  runbook_type            = "PowerShell"

  content = data.local_file.updatemanagement-turnoffvms.content
}

resource "azurerm_automation_runbook" "updatemanagement-turnonvms" {
  name                    = "UpdateManagement-TurnOnVms"
  location                = var.location
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
  automation_account_name = var.automation_account_name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Runbook to TurnOn Virtual Machines after Windows Updates have been installed"
  runbook_type            = "PowerShell"

  content = data.local_file.updatemanagement-turnonvms.content

}

resource "azurerm_automation_runbook" "scheduledstartstopvm" {
  name                    = "ScheduledStartStopVm"
  location                = var.location
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
  automation_account_name = var.automation_account_name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Runbook to Start/Stop/Restart Virtual Machines on a Automation schedule"
  runbook_type            = "PowerShell"

  content = data.local_file.scheduledstartstopvm.content

}

# This schedule will be used simply turn on the VMs after patch tuesday


# Create a schedule for the Automation Runbook to run (see schedule)
resource "azurerm_automation_schedule" "updatemanagement-scheduleafterpatchtuesday" {
  name                    = "ScheduleAfterPatchTuesday"
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  frequency               = "Week"
  # Every wednesday
  interval = 1
  timezone = "Europe/Amsterdam" # Change to your desired timezone

  week_days  = ["Wednesday"]
  start_time = local.start_time
}

# Link the Runbook to the schedule
resource "azurerm_automation_job_schedule" "updatemanagement-link-notebook-to-scheduleafterpatchtuesday" {
  automation_account_name = var.automation_account_name
  schedule_name           = "ScheduleAfterPatchTuesday"
  runbook_name            = "ScheduledStartStopVm"
  resource_group_name     = var.resource_group_name

  parameters = { #Error: Due to a bug in Azure parameter names need to be lowercase 
    action = "start"
  }
  depends_on = [
    azurerm_automation_runbook.scheduledstartstopvm,
    azurerm_automation_runbook.scheduledstartstopvm
  ]
}
