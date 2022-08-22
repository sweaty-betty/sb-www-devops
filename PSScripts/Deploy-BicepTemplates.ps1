<#
.SYNOPSIS
Tests an ARM template file

.DESCRIPTION
Tests a ARM template file to make sure it should deploy.

.PARAMETER ParameterFile
Parameter file with manditory and optional parameters to test with.
Normally contains dummy values unless it is a dependancy in which case a valid value is needed.

.PARAMETER TemplateFile
The template file to test

.PARAMETER ResourceGroupName
The name of the resource group to test the ARM template against.  Defaults to template-test-az-sb-iaas-nonprod-uks-rg

.PARAMETER BuildNumber
The name of the resource group to test the ARM template against.  Defaults to template-test-az-sb-iaas-nonprod-uks-rg

.EXAMPLE
Test-ArmTemplate.ps1 -ParameterFile paramaters.json -TemplateFile template.json -BuildNumber 20220529.18

#>
[CmdletBinding()]
Param(
    [string] $ParameterFile,
    [string] $TemplateFile,
    [string] $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg",
    [string] $BuildNumber = "BuildNumber"
)


$template_name = "Template_$($BuildNumber)"

$DeploymentParameters = @{
    ResourceGroupName     = $ResourceGroupName
    TemplateFile          = $TemplateFile
    TemplateParameterFile = $ParameterFile
    TemplateName          = $template_name
    Verbose               = $true
}

Write-Host "- Creating Deployment template"
if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent) {

    Write-Verbose -Message "Deployment Parameters:"
    $DeploymentParameters

}


az deployment group create --name $template_name --resource-group $ResourceGroupName --template-file $TemplateFile --parameters @($ParameterFile)
