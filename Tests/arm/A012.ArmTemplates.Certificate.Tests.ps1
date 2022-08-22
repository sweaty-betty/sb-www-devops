Describe "Certificate Deployment Tests" -Tag "Acceptance" {

  BeforeAll {
    # common variables
    $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
    $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\certificate.json"
  }
  
  Context "When a single certificate from the key vault is created" {

    BeforeAll {
      $TemplateParameters = @{
        keyVaultName            = "sb-foo-bar-kv"
        keyVaultCertificateName = "foo.example.com"
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