AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0063ebc81c5fcfe82"
INSTANCES=( "forntend" )
ZONE_ID="Z066140621FS3C4YYVXA1"
DOMAIN_NAME="tadikondadevops.site"

for instance in ${INSTANCES[@]}

do

INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-0063ebc81c5fcfe82 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=chinna}]" --query "Instances[0].PrivateIpAddress" --output text)

if [ $instance != "forntend" ]
then 
   IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
 else 
      IP=$(aws ec2 describe-instances --instance-ids  $INSTANCE_ID--query "Reservations[0].Instances[0].PublicIpAddress" --output text)

fi
   echo " $instance IP address: $IP"
done
