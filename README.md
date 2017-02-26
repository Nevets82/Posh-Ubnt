# Posh-Ubnt PowerShell Ubnt Module

This PowerShell module provides some functionality to facilitate automating backup actions of a Ubnt device over SSH.

## Similar Projects

Here are some similar projects I am working on:

* [Posh-Cisco (PowerShell Cisco Module)](https://www.powershellgallery.com/packages/Posh-Cisco "Posh-Cisco PowerShell Cisco Module")
* [Posh-FortiGate (PowerShell FortiGate Module)](https://www.powershellgallery.com/packages/Posh-FortiGate "Posh-FortiGate PowerShell FortiGate Module")
* [Posh-Juniper (PowerShell Juniper Module)](https://www.powershellgallery.com/packages/Posh-Juniper "Posh-Juniper PowerShell Juniper Module")

## Dependencies

This module depends on the following PowerShell modules:

* [Posh-SSH (PowerShell SSH Module)](https://www.powershellgallery.com/packages/Posh-SSH "Posh-SSH PowerShell SSH Module") 

## Inspect

```PowerShell
PS> Save-Module -Name Posh-Ubnt -Path <path>
```

## Install

```PowerShell
PS> Install-Module -Name Posh-Ubnt
```

## Functionality

* Backup-UbntRunningConfig: Gets the running configuration and writes it to a file.
* Backup-UbntSystemConfig: Gets the system (startup) configuration and writes it to a file.
* Get-UbntRunningConfig: Gets the running configuration.
* Get-UbntSystemConfig: Gets the system (startup) configuration.

## Usage

### Backup Running Configuration

This PowerShell command gets the running configuration and writes it to a file.

```PowerShell
PS> Backup-UbntRunningConfig -HostAddress "192.168.1.20" -HostPort 22 -Credential (Get-Credential) -FilePath "$([Environment]::GetFolderPath(“MyDocuments”))\running-config.txt"
```

Advanced Options:

* Specify the ```-AcceptKey``` flag to automatically accept SSH key.

### Backup System Configuration

This PowerShell command gets the sytem (startup) configuration and writes it to a file.

```PowerShell
PS> Backup-UbntSystemConfig -HostAddress "192.168.1.20" -HostPort 22 -Credential (Get-Credential) -FilePath "$([Environment]::GetFolderPath(“MyDocuments”))\system-config.txt"
```

Advanced Options:

* Specify the ```-AcceptKey``` flag to automatically accept SSH key.

### Get Running Configuration

This PowerShell command gets the running configuration.

```PowerShell
PS> Get-UbntRunningConfig -HostAddress "192.168.1.20" -HostPort 22 -Credential (Get-Credential)
```

Advanced Options:

* Specify the ```-AcceptKey``` flag to automatically accept SSH key.

### Get System Configuration

This PowerShell command gets the system (startup) configuration.

```PowerShell
PS> Get-UbntSystemConfig -HostAddress "192.168.1.20" -HostPort 22 -Credential (Get-Credential) 
```

Advanced Options:

* Specify the ```-AcceptKey``` flag to automatically accept SSH key.

### Get Log Messages

This PowerShell command gets the log messages.

```PowerShell
PS> Get-UbntLogMessages -HostAddress "192.168.1.20" -HostPort 22 -Credential (Get-Credential) 
```

Advanced Options:

* Specify the ```-AcceptKey``` flag to automatically accept SSH key.

## Compatibility

These PowerShell functions were tested on the following Ubnt devices:

* TOUGHSwitch TS-5-PoE (SW version: 1.3.2)
* TOUGHSwitch TS-8-PRO (SW version: 1.3.2)

## Change Log

### Version 1.0.0

#### New Features

* Added documentation
* Added support to backup running config (Backup-UbntRunningConfig)
* Added support to backup system config (Backup-UbntSystemConfig)
* Added support to get running config (Get-UbntRunningConfig)
* Added support to get system config (Get-UbntSystemConfig)
* Added support to get log messages (Get-UbntLogMessages)

## Todo

* Test on more devices
* ...
