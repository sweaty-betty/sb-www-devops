
Describe "Service Bus Queue Authorization Rule (shared access policy) Deployment Tests" -Tag "Acceptance" {

  BeforeAll {
    # common variables
    $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
    $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\ServiceBus\servicebus-queue-authrule.json"


  }
  Context "When deploying a shared access policy to a Service Bus Queue" {

    BeforeAll {
      $TemplateParameters = @{
        servicebusName        = "sb-foo-bar-ns"
        queueName             = "queue-name"
        authorizationRuleName = "myrule"
        rights                = @( "listen" )
      }
      $TestTemplateParams = @{
        ResourceGroupName       = $ResourceGroupName
        TemplateFile            = $TemplateFile
        TemplateParameterObject = $TemplateParameters
      }
    }

    It "Should be deployed successfully with just a subscription"  {
      $output = Test-AzureRmResourceGroupDeployment @TestTemplateParams
      $output | Should -Be $null

      if ($output) {
        Write-Error $output.Message
      }
  
    }

  }
}