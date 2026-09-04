using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Amazon.EC2;
using Amazon.EC2.Model;
using Amazon.Lambda.Core;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace BackupAutomation
{
    public class BackupFunction
    {
        private readonly AmazonEC2Client _ec2Client;
        public BackupFunction()
        {
            _ec2Client = new AmazonEC2Client();
        }
        public async Task FunctionHandler(object input, ILambdaContext context)
        {
            context.Logger.LogInformation($"EC2 Backup process started at: {DateTime.UtcNow}");

            try
            {
                var instances = await GetInstancesWithBackupTagAsync(context);
                context.Logger.LogInformation($"Found {instances.Count} instance(s) marked for backup.");
                foreach (var instance in instances)
                {
                    context.Logger.LogInformation($"Processing instance: {instance.InstanceId}");

                    foreach (var blockDevice in instance.BlockDeviceMappings)
                    {
                        string volumeId = blockDevice.Ebs?.VolumeId;
                        if (string.IsNullOrEmpty(volumeId)) continue;
                        string description = $"Automated backup for {instance.InstanceId} ({blockDevice.DeviceName}) at {DateTime.UtcNow:yyyy-MM-dd}";
                        var snapshotRequest = new CreateSnapshotRequest
                        {
                            VolumeId = volumeId,
                            Description = description,
                            TagSpecifications = new List<TagSpecification>
                            {
                                new TagSpecification
                                {
                                    ResourceType = ResourceType.Snapshot,
                                    Tags = new List<Tag>
                                    {
                                        new Tag { Key = "CreatedBy", Value = "LambdaBackupRoutine" },
                                        new Tag { Key = "OriginalInstance", Value = instance.InstanceId }
                                    }
                                }
                            }
                        };

                        var response = await _ec2Client.CreateSnapshotAsync(snapshotRequest);
                        context.Logger.LogInformation($"Snapshot created: {response.Snapshot.SnapshotId} for Volume: {volumeId}");
                    }
                }
            }
            catch (Exception ex)
            {
                context.Logger.LogError($"Error during EC2 backup sequence: {ex.Message}");
                throw;
            }
        }
        private async Task<List<Instance>> GetInstancesWithBackupTagAsync(ILambdaContext context)
        {
            var taggedInstances = new List<Instance>();
            var request = new DescribeInstancesRequest
            {
                Filters = new List<Filter>
                {
                    new Filter
                    {
                        Name = "tag-key",
                        Values = new List<string> { "backup" }
                    },
                    new Filter
                    {
                        Name = "instance-state-name",
                        Values = new List<string> { "running", "stopped" }
                    }
                }
            };
            string nextToken = null;
            do
            {
                request.NextToken = nextToken;
                var response = await _ec2Client.DescribeInstancesAsync(request);

                foreach (var reservation in response.Reservations)
                {
                    taggedInstances.AddRange(reservation.Instances);
                }

                nextToken = response.NextToken;
            } while (!string.IsNullOrEmpty(nextToken));

            return taggedInstances;
        }
    }
}