<#
.SYNOPSIS
Runs the Code Quality tests

.DESCRIPTION
Runs the Code Quality tests

.EXAMPLE
Q002.Powershell.Quality.Tests.ps1

#>

BeforeDiscovery {
    $files = Get-ChildItem -Path $PSScriptRoot\..\*.ps1 -File -Recurse | Where-Object {$_.FullName -notlike "*.Tests.ps1" -and $_.FullName -notlike "*Pester.ps1"}
    Write-Host "File count discovered for Code quality Tests: $($files.Count)"
}
Describe "Code quality tests" -ForEach @($files) -Tag "Quality" {

    BeforeDiscovery {
        $ScriptName = $_.FullName
        Write-Output "Script name: $($ScriptName)"
        $ExcludeRules = @(
            "PSUseSingularNouns",
            "PSAvoidUsingWriteHost",
            "PSAvoidUsingEmptyCatchBlock",
            "PSAvoidUsingPlainTextForPassword",
            "PSAvoidUsingConvertToSecureStringWithPlainText",
            "PSUseShouldProcessForStateChangingFunctions"
        )
        Write-Output "Exclude Rules Count: $($ExcludeRules.Count)"
        $Rules = Get-ScriptAnalyzerRule
        Write-Output "Rules Count: $($Rules.Count)"
    }

    Context "Code Quality Test $ScriptName" -Foreach @{scriptName = $scriptName; rules = $Rules; excludeRules = $ExcludeRules } {
        It "Should pass Script Analyzer rule '<_>'" -ForEach @($Rules) {
            $Result = Invoke-ScriptAnalyzer -Path $($scriptName) -IncludeRule $_ -ExcludeRule $ExcludeRules
            $Result.Count | Should -Be 0
        }
    }
}