BeforeAll {
  # common variables
  $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
  $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\azure-search.json"
}

Describe "Azure Search Deployment Tests" -Tag "Acceptance" {

  Context "When Azure Search is deployed with just search name" {
    BeforeAll {
      $TemplateParameters = @{
        azureSearchName = "sb-foo-bar-sch-01"
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

  Context "When Azure Search is deployed with tier (sku) set to standard" {

    BeforeAll {
      $TemplateParameters = @{
        azureSearchName = "sb-foo-bar-sch-02"
        azureSearchSku  = "standard"
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

  Context "When Azure Search is deployed with all parameters supplied" {

    BeforeAll {
      $TemplateParameters = @{
        azureSearchName           = "sb-foo-bar-sch-03"
        azureSearchSku            = "standard2"
        azureSearchReplicaCount   = 2
        azureSearchPartitionCount = 2
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