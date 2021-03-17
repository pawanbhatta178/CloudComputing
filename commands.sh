aws ec2 run-instances --image-id ami-0915bcb5fa77e4892 --count 1  --instance-type t2.micro --key-name my-first-ec2-key

{
     "InstanceId": "i-04e9eecc868890365"
}

aws ec2 describe-instances --instance-ids i-04e9eecc868890365

ssh -i "my-first-ec2-key.pem" ec2-user@ec2-54-197-190-215.compute-1.amazonaws.com

sudo su

Ctrl+D to  logout

aws ec2 create-image --instance-id i-04e9eecc868890365 --name  my_first_custom_image

{
    "ImageId": "ami-04cf0c486685e3dd3"
}

aws ec2 create-image --instance-id i-04e9eecc868890365 --name  my_first_custom_image
{
    "ImageId": "ami-04cf0c486685e3dd3"
}
aws ec2 describe-images --image-ids ami-04cf0c486685e3dd3

##Closing down the previous instance
aws ec2 terminate-instances --instance-ids i-04e9eecc868890365

##Starting new instance using custom ami
aws ec2 run-instances --image-id ami-04cf0c486685e3dd3 --count 1 --instance-type t2.micro --key-name my-first-ec2-key

           
##Result  
{
    "Instances":[
        {
         "InstanceId": "i-0c1cad88d0d21d3e7"
        }
    ]
}

##Terminating the new instance
aws ec2 terminate-instances --instance-ids i-0c1cad88d0d21d3e7


##Deregistering ami image
aws ec2 deregister-image --image-id ami-04cf0c486685e3dd3

##Getting the snapshot id associated with the ami
aws ec2 describe-snapshots| grep -A5 -b5 ami-04cf0c486685e3dd3 
##Result
"SnapshotId": "snap-06ba4a2a32bf00249"

##Deleting th snapshot 
aws ec2 delete-snapshot --snapshot-id snap-06ba4a2a32bf00249