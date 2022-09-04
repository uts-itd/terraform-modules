package tests

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	tfjson "github.com/hashicorp/terraform-json"
	"github.com/stretchr/testify/assert"
)

func TestTerraformVPCMinimal(t *testing.T) {
	t.Parallel()

	tempDirectory := test_structure.CopyTerraformFolderToTemp(t, "../examples", "minimal")
	planFilePath := filepath.Join(tempDirectory, "plan.out")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/minimal",
		PlanFilePath: planFilePath,
	})

	plan := terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.vpc.aws_vpc.main")

	// Check if there's more than one subnet
	privateSubnetHA := plan.ResourcePlannedValuesMap["module.vpc.aws_subnet.private[1]"]
	assert.Equal(t, ((*tfjson.StateResource)(nil)), privateSubnetHA)

	// Check if there's more than one subnet
	publicSubnetHA := plan.ResourcePlannedValuesMap["module.vpc.aws_subnet.public[1]"]
	assert.Equal(t, ((*tfjson.StateResource)(nil)), publicSubnetHA)

	// Check if there's more than one subnet
	natGatewayHA := plan.ResourcePlannedValuesMap["module.vpc.aws_nat_gateway.main[1]"]
	assert.Equal(t, ((*tfjson.StateResource)(nil)), natGatewayHA)
}