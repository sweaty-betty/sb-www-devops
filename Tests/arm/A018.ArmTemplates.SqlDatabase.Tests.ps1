
Describe "Sql Database Deployment Tests" -Tag "Acceptance" {
    BeforeAll {
        # common variables
        $ResourceGroupName = "template-test-az-sb-iaas-nonprod-uks-rg"
        $TemplateFile = "$PSScriptRoot\..\..\ArmTemplates\SqlServer\sql-database.json"
        $TemplateParametersDefault = @{
            databaseName  = "sb-foo-bar-db"
            sqlServerName = "sb-foo-bar-sql"
        }
    }
        
    Context "When SQL Database is deployed with databaseName, sqlServerName" {

        BeforeAll {
            $TemplateParameters = $TemplateParametersDefault
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

    Context "When SQL Database is deployed with databaseName, sqlServerName and databaseTier of Basic" {

        BeforeAll {
            $TemplateParameters = $TemplateParametersDefault
            $TemplateParameters['databaseTier'] = "Basic"
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

    Context "When SQL Database is deployed with databaseName, sqlServerName and databaseTier of Standard and a databaseSize of 2" {

        BeforeAll {
            $TemplateParameters = $TemplateParametersDefault
            $TemplateParameters['databaseTier'] = "Standard"
            $TemplateParameters['databaseSize'] = "2"
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