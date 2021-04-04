# graphicsmagick
Remove-Alias -Name gm -Force -ErrorAction SilentlyContinue
# nvim
Set-Alias -Name vim -Value nvim
# Set-Alias -Name code -Value nvim
Set-Alias -Name gvim -Value gnvim
Set-Alias -Name v -Value gnvim
Set-Alias -Name bpython -Value "bpython-curses"

# so you can use latex <file> to compile it with latexmk
Function latex {
    latexmk -pdf -pvc -view=none $args
}

# modules!
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
Import-Module posh-git
Import-Module DockerCompletion
Import-Module PSDotFiles

# this module isn't packaged yet
$gscpc_folder = "${HOME}/Documents/PowerShell/Modules/git-status-cache-posh-client"
# if we don't have it yet, clone it down
if (!(Test-Path $gscpc_folder)) {
    git clone --depth 1 https://github.com/guppy0130/git-status-cache-posh-client.git "$gscpc_folder"
    # run install if bin/ doesn't exist
    if (!(Test-Path "$gcspc_folder/bin/GitStatusCache.exe")) {
        & "$gscpc_folder/install.ps1"
    }
}
Import-Module "$gscpc_folder\GitStatusCachePoshClient.psm1"

# ...for some reason, we still need the EDITOR variable...
Set-Variable -Name "EDITOR" -Value "nvim"
Set-Variable -Name "FZF_DEFAULT_COMMAND" -Value 'rg --files --hidden --follow --glob "!.git/*"'
Set-Variable -Name "FZF_CTRL_T_OPTS" -Value '--preview "bat --style=numbers --color=always --line-range :500 {}"'
Set-Variable -Name "DotFilesPath" -Value "$HOME\dotfiles"

# stuff for posh-git
# write the status first then the path
$GitPromptSettings.DefaultPromptWriteStatusFirst = $true
# put a space between path and delimiter
$GitPromptSettings.DefaultPromptSuffix = " "
$GitPromptSettings.WindowTitle = $null

# set the prompt! this allows us to add posh-git if it exists, but not explode
# if it we don't have it.
Function prompt {
    if (!(Get-Module -ListAvailable -Name posh-git)) {
        # no posh-git, use fallback path
        $returnable = "$($executionContext.SessionState.Path.CurrentLocation)"
    }
    else {
        $returnable = & $GitPromptScriptBlock
    }

    # configure prompt-character/delimiter
    # 1/100 magic
    if ((Get-Random -Maximum 100) -eq 99) {
        $delimiter = "`n(っ・ω・）っ——☆"
    }
    else {
        $delimiter = "λ"
    }
    # disallow magic on admin prompt; no funny shenanigans allowed
    if ($Global:GitPromptValues.IsAdmin) {
        $delimiter = "#"
    }

    if ($LastExitCode -eq 0) {
        $returnable += Write-Prompt "$delimiter" -ForegroundColor ([ConsoleColor]::Green)
    }
    else {
        $returnable += Write-Prompt "$delimiter" -ForegroundColor ([ConsoleColor]::Red)
    }
    "$returnable "
}
