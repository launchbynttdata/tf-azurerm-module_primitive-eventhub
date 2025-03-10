package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	armEventhub "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/eventhub/armeventhub"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestEventhubModule(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	armEventhubClient, err := armEventhub.NewEventHubsClient(subscriptionId, credential, &options)
	if err != nil {
		t.Fatalf("Error getting Eventhub client: %v", err)
	}

	t.Run("doesEventhubExist", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		eventhubNamespaceName := terraform.Output(t, ctx.TerratestTerraformOptions(), "eventhub_namespace_name")
		eventhubName := terraform.Output(t, ctx.TerratestTerraformOptions(), "eventhub_name")

		eventhub, err := armEventhubClient.Get(context.Background(), resourceGroupName, eventhubNamespaceName, eventhubName, nil)
		if err != nil {
			t.Fatalf("Error getting eventhub: %v", err)
		}

		assert.Equal(t, eventhubName, *eventhub.Name)
	})
}
