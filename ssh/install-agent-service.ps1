$params = @{
    Name           = "ssh-agent-8.1"
    BinaryPathName = "$env:ProgramFiles/OpenSSH/ssh-agent.exe"
    DisplayName    = "OpenSSH Agent"
    StartupType    = "AutomaticDelayedStart"
    Description    = "Agent to hold SSH private keys"
}

New-Service @params
