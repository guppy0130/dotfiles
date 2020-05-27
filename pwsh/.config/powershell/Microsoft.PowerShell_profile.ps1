# graphicsmagick
Remove-Alias -Name gm -Force -ErrorAction SilentlyContinue
# nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name code -Value nvim
Set-Alias -Name gvim -Value gnvim
Set-Alias -Name v -Value gnvim

Function latex {
    latexmk -pdf -pvc -view=none $args
}

# python-language-server
Function pyls {
    docker run --rm --name pyls -it python:2-alpine sh -c 'apk add build-base > /dev/null && pip install python-language-server > /dev/null && pyls'
}

# modules!
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
Import-Module posh-git
Import-Module DockerCompletion
Import-Module PSDotFiles

# ...for some reason, we still need the EDITOR variable...
Set-Variable -Name "EDITOR" -Value "nvim"
Set-Variable -Name "FZF_DEFAULT_COMMAND" -Value 'rg --files --hidden --follow --glob "!.git/*"'
Set-Variable -Name "DotFilesPath" -Value "$HOME\dotfiles"

# stuff for posh-git
$GitPromptSettings.DefaultPromptWriteStatusFirst = $true
$GitPromptSettings.DefaultPromptSuffix = " "
$GitPromptSettings.WindowTitle = ""

# set the prompt!
Function prompt {
    if (!(Get-Module -ListAvailable -Name posh-git)) {
        # no posh-git, use fallback path
        $returnable = "$($executionContext.SessionState.Path.CurrentLocation)"
    } else {
        $returnable = & $GitPromptScriptBlock
    }

    # configure prompt-character/delimiter
    $isAdmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $delimiter = "λ"
    if ($isAdmin) {
        $delimiter = "#"
    }

    if ($LastExitCode -eq 0) {
        $returnable += Write-Prompt "$($delimiter * ($nestedPromptLevel + 1))" -ForegroundColor ([ConsoleColor]::Green)
    } else {
        $returnable += Write-Prompt "$($delimiter * ($nestedPromptLevel + 1))" -ForegroundColor ([ConsoleColor]::Red)
    }
    "$returnable "
}