
Describe "Service Bus Topic Deployment Tests" -Tag "Acceptance" {

  BeforeAll {
    # common variables
    $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
    $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\ServiceBus\servicebus-topic.json"
  }
  
  Context "When deploying the Service Bus Topic" {

    BeforeAll {
      $TemplateParameters = @{
        serviceBusNamespaceName = "sb-foo-bar-ns"
        serviceBusTopicName     = "topic-name"
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

    if ($output) {
      Write-Error $output.Message
    }

  }
}