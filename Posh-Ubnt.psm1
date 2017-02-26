# Posh-Ubnt PowerShell Ubnt Module
# Copyright (c) 2017 Steven Lietaer, All rights reserved.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# Import PowerShell SSH Module
Import-Module Posh-SSH;

# .ExternalHelp Posh-Ubnt.psm1-Help.xml
function Get-UbntSSHResponse
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey,
		[Parameter(Mandatory=$true)]
		[String]$Command,
		[Parameter(Mandatory=$false)]
		[String]$StripHeaderAt = $null
    )

    $SSHSession = New-SSHSession -ComputerName $HostAddress -Port $HostPort -Credential $Credential -AcceptKey:$AcceptKey;
        
    if ($SSHSession.Connected)
    {
        $SSHResponse = Invoke-SSHCommand -SSHSession $SSHSession -Command $Command;
    
        Remove-SSHSession -SSHSession $SSHSession | Out-Null;

        $Result = $SSHResponse.Output | Out-String;

        $StartIndex = 0;

        if ($StripHeaderAt)
        {
            $StartIndex = $Result.IndexOf("`n$StripHeaderAt") + 1;
        }

        return $Result.Substring($StartIndex).Trim();
    }
    else
    {
        throw [System.InvalidOperationException]"Could not connect to SSH host: $($HostAddress):$HostPort.";
    }
}

# .ExternalHelp Posh-Ubnt.psm1-Help.xml
function Get-UbntRunningConfig
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-UbntSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'cat /tmp/running.cfg' -StripHeaderAt $null);
}

# .ExternalHelp Posh-Ubnt.psm1-Help.xml
function Backup-UbntRunningConfig
{
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey,
		[Parameter(Mandatory=$true)]
		[String]$FilePath
    )

    Get-UbntRunningConfig -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey | Out-File -FilePath $FilePath -Encoding ascii;
}

# .ExternalHelp Posh-Ubnt.psm1-Help.xml
function Get-UbntSystemConfig
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-UbntSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'cat /tmp/system.cfg' -StripHeaderAt $null);
}

# .ExternalHelp Posh-Ubnt.psm1-Help.xml
function Backup-UbntSystemConfig
{
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey,
		[Parameter(Mandatory=$true)]
		[String]$FilePath
    )

    Get-UbntSystemConfig -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey | Out-File -FilePath $FilePath -Encoding ascii;
}

# .ExternalHelp Posh-Ubnt.psm1-Help.xml
function Get-UbntLogMessages
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )
    
    return (Get-UbntSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'cat /var/log/messages' -StripHeaderAt $null);
}
