using System;
using System.Threading.Tasks;
using Amazon.Lambda.Core;
using Amazon.EC2;
using Amazon.EC2.Model;
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace LambdaStopEC2
{
    public class Function
    {
        public async Task FunctionHandler(ILambdaContext context)
        {
            var instanceId = Environment.GetEnvironmentVariable("INSTANCE_ID"); // Fetch instance ID from Lambda env variables

            if (string.IsNullOrEmpty(instanceId))
            {
                context.Logger.LogLine("Instance ID not set in environment variables.");
                return;
            }

            using (var ec2Client = new AmazonEC2Client())
            {
                try
                {
                    var stopRequest = new StopInstancesRequest
                    {
                        InstanceIds = new List<string> { instanceId },
                        Force = false // set true to forcibly stop
                    };

                    var response = await ec2Client.StopInstancesAsync(stopRequest);
                    context.Logger.LogLine($"Stop request for instance {instanceId} sent successfully.");
                    foreach (var stopInstance in response.StoppingInstances)
                    {
                        context.Logger.LogLine($"Instance {stopInstance.InstanceId} status: {stopInstance.CurrentState.Name}");
                    }
                }
                catch (Exception ex)
                {
                    context.Logger.LogLine($"Error stopping instance: {ex.Message}");
                }
            }
        }
    }
}