package tests

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformVPCCore(t *testing.T) {
	t.Parallel()

	tempDirectory := test_structure.CopyTerraformFolderToTemp(t, "../examples", "core")
	planFilePath := filepath.Join(tempDirectory, "plan.out")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/core",
		PlanFilePath: planFilePath,
	})

	plan := terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)

	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.vpc.aws_vpc.main")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.vpc.aws_subnet.public[0]")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.vpc.aws_subnet.private[0]")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.vpc.aws_route_table.public")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.vpc.aws_route_table.private")
}