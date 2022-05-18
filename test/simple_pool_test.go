package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()

	customer_prefix := "krb"
	environment_suffix := "prd"
	name := "test"
	user_attributes := []map[string]interface{}{
		{
			"name":                     "rut",
			"attribute_data_type":      "String",
			"mutable":                  true,
			"required":                 false,
			"developer_only_attribute": false,
		},
	}
	password_policy := []map[string]interface{}{
		{
			"minimum_length":                   16,
			"require_lowercase":                true,
			"require_numbers":                  true,
			"require_uppercase":                true,
			"require_symbols":                  false,
			"temporary_password_validity_days": 1,
		},
	}
	common_tags := map[string]string{
		"environment": "production",
		"project":     "Karibu Labs",
		"customer":    "Karibu",
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"customer_prefix":    customer_prefix,
			"environment_suffix": environment_suffix,
			"name":               name,
			"user_attributes":    user_attributes,
			"password_policy":    password_policy,
			"common_tags":        common_tags,
		},
		BackendConfig: map[string]interface{}{
			"bucket": os.Getenv("AWS_BACKEND_BUCKET"),
			"key":    os.Getenv("AWS_BACKEND_KEY"),
		},
		EnvVars: map[string]string{
			"AWS_SECRET_ACCESS_KEY": os.Getenv("AWS_SECRET_ACCESS_KEY"),
			"AWS_ACCESS_KEY_ID":     os.Getenv("AWS_ACCESS_KEY_ID"),
			"AWS_DEFAULT_REGION":    os.Getenv("AWS_DEFAULT_REGION"),
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	cognitoPoolId := terraform.Output(t, terraformOptions, "cognito_pool_id")
	cognitoClientId := terraform.Output(t, terraformOptions, "cognito_client_id")

	assert.NotNil(t, cognitoPoolId)
	assert.NotNil(t, cognitoClientId)
}
