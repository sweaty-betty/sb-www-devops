Describe "Service Bus Topic Authorization Rule (shared access policy) Deployment Tests" -Tag "Acceptance" {

  BeforeAll {
    # common variables
    $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
    $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\ServiceBus\servicebus-topic-authrule.json"

  }
  Context "When deploying a shared access policy to a Service Bus Topic" {

    BeforeAll {

      $TemplateParameters = @{
        servicebusName        = "sb-foo-bar-ns"
        topicName             = "topic-name"
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