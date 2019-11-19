function Get-Service {
<#
        .SYNOPSIS
            Gets the services on the computer.
        .DESCRIPTION
            Retreives services on a computer, including running and stopped services. By default, without parameters, all local services will be returned.
        .INPUTS
            System.String
        .OUTPUTS
            Output of systemctl.
        .EXAMPLE
            Get-Service -Name sshd.service
            Get-Service -DisplayName default-kernel.path
#>

  #Requires -Version 6.0

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false,ValueFromPipeline = $true)]
    [string[]]$Name,
    [Parameter(Mandatory = $false)]
    [string[]]$DisplayName,
    [Parameter(Mandatory = $false)]
    [string[]]$Include,
    [Parameter(Mandatory = $false)]
    [string[]]$Exclude
  )

  $Output = (/usr/bin/env systemctl status $Name $Include $DisplayName)

  $Output
}

function Start-Service {
<#
        .SYNOPSIS
            Starts one or more stopped services.
        .DESCRIPTION
            Sends a start message to systemctl for each of the specified services. If a service is already running, the message is ignored without error. You can specify the services by their service names or display names that represent the services that you want to start.
        .INPUTS
            System.String
        .OUTPUTS
            If no error is generated, then nothing.
        .EXAMPLE
            Start-Service -Name sshd.service
            Start-Service -Confirm -DisplayName default-kernel.path
#>

  #Requires -Version 6.0

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [switch]$Confirm,
    [Parameter(Mandatory = $false,ValueFromPipeline = $true)]
    [string[]]$Name,
    [Parameter(Mandatory = $false)]
    [string[]]$DisplayName,
    [Parameter(Mandatory = $false)]
    [string[]]$Include,
    [Parameter(Mandatory = $false)]
    [string[]]$Exclude
  )

  $Question = 'Are you sure you want to perform this action?'
  $Choices = '&Yes', '&No'

  if ($Confirm) {
    $Decide = $Host.UI.PromptForChoice('Confirm', $Question, $Choices, 1)
    if ($Decide  -ne 0) {
      return
    }
  }

  $Output = (/usr/bin/env systemctl start $Name $Include $DisplayName)

  $Output
}

function Stop-Service {
<#
        .SYNOPSIS
            Stops one or more running services.
        .DESCRIPTION
            Sends a stop message to systemctl for each of the specified services. You can specify the services by their service names or display names that represent the services that you want to stop.
        .INPUTS
            System.String
        .OUTPUTS
            If no error is generated, then nothing.
        .EXAMPLE
            Stop-Service -Name sshd.service
            Stop-Service -Confirm -DisplayName default-kernel.path
#>

  #Requires -Version 6.0

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [switch]$Confirm,
    [Parameter(Mandatory = $false)]
    [switch]$Force,
    [Parameter(Mandatory = $false,ValueFromPipeline = $true)]
    [string[]]$Name,
    [Parameter(Mandatory = $false)]
    [string[]]$DisplayName,
    [Parameter(Mandatory = $false)]
    [string[]]$Include,
    [Parameter(Mandatory = $false)]
    [string[]]$Exclude
  )

  $Question = 'Are you sure you want to perform this action?'
  $Choices = '&Yes', '&No'

  if ($Confirm) {
    $Decide = $Host.UI.PromptForChoice('Confirm', $Question, $Choices, 1)
    if ($Decide  -ne 0) {
      return
    }
  }

  $IsForced = ""

  if ($Force) {
    $IsForced = "--force"
  }

  $Output = (/usr/bin/env systemctl stop $IsForced $Name $Include $DisplayName)

  $Output
}

function Restart-Service {
<#
        .SYNOPSIS
            Stops and then starts one or more services.
        .DESCRIPTION
            Sends a stop message to systemctl for each of the specified services, then sends a start message for each of the specified services. You can specify the services by their service names or display names that represent the services that you want to restart.
        .INPUTS
            System.String
        .OUTPUTS
            If no error is generated, then nothing.
        .EXAMPLE
            Restart-Service -Name sshd.service
            Restart-Service -Confirm -DisplayName default-kernel.path
#>

  #Requires -Version 6.0

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)]
    [switch]$Confirm,
    [Parameter(Mandatory = $false)]
    [switch]$Force,
    [Parameter(Mandatory = $false,ValueFromPipeline = $true)]
    [string[]]$Name,
    [Parameter(Mandatory = $false)]
    [string[]]$DisplayName,
    [Parameter(Mandatory = $false)]
    [string[]]$Include,
    [Parameter(Mandatory = $false)]
    [string[]]$Exclude
  )

  $Question = 'Are you sure you want to perform this action?'
  $Choices = '&Yes', '&No'

  if ($Confirm) {
    $Decide = $Host.UI.PromptForChoice('Confirm', $Question, $Choices, 1)
    if ($Decide  -ne 0) {
      return
    }
  }

  $IsForced = ""

  if ($Force) {
    $IsForced = "--force"
  }

  $Output = (/usr/bin/env systemctl restart $IsForced $Name $Include $DisplayName)

  $Output
}
