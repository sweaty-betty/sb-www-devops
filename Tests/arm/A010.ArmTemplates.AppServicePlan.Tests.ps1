
Describe "App Service Plan Deployment Tests" -Tag "Acceptance" {
  
  BeforeAll {
    # common variables
    $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
    $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\app-service-plan.json"
  }
  Context "When an app service plan is deployed with just name" {

    BeforeAll {
      $TemplateParameters = @{
        appServicePlanName = "sb-foo-bar-asp"
      }
      $TestTemplateParams = @{
        ResourceGroupName       = $ResourceGroupName
        TemplateFile            = $TemplateFile
        TemplateParameterObject = $TemplateParameters
      }
    }
 
    It "Should be deployed successfully" {
      $output = Test-AzureRmResourceGroupDeployment @TestTemplateParams
      $output | Should -Be $null
    }

  }
}