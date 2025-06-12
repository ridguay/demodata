data "local_file" "updatemanagement-turnoffvms" { # do not use
  filename = "${path.module}/automation_runbooks/UpdateManagement-TurnOffVms.ps1"
}

data "local_file" "updatemanagement-turnonvms" { # do not use
  filename = "${path.module}/automation_runbooks/UpdateManagement-TurnOnVms.ps1"
}

data "local_file" "scheduledstartstopvm" {
  filename = "${path.module}/automation_runbooks/ScheduledStartStopVm.ps1"
}
