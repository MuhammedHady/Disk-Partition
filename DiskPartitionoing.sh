#! /bin/bash
##################################################################
##                                                              ## 
## This Bash Script is for autmating the process of Creatning   ##
## Partitions on each disk in easy way !                        ##
##                                                              ##                  
##################################################################

###### Declaring Some in-Code needed variables ###################

num=1
bum=1

####################### Code Build ###############################

echo " Enter the disk's name : "
read diskinput
if [ -b /dev/$diskinput ]																		## -b is used to deal with blockfile search
then
	echo " yup, found ! "
	echo " Enter the no. of partitions you want to make as Primary ( max=4 ) :  "
	read numb
	while [ $num -le $numb ]																	 ## a loop creating the partition with size,type, and creating it's mount directory
	do
	echo " Enter the size you want for Partition $num (ex:2G) : "
	read sizz
	echo " Enter Patition id type ( for normal linux choose 83 ) : "
	read typp
        echo " /dev/$diskinput$num : size= $sizz , type= $typp " >> /tmp/configfile$diskinput
        mkdir -p /MOUNTS/$diskinput/$diskinput$num
        num=$(( $num + 1))
	done

	sfdisk /dev/$diskinput < /tmp/configfile$diskinput
				  ## The Automating Command to add the configfile setup to the disk
	echo "select your file system type (ex: ext4 / xfs) : "
	read fsxt
	while [ $bum -le $numb ] 
				  ## a loop to create each partition it's file system then mount it's mounting point created earlier
	do
	echo "select your file system type for $diskinput$bum (ex: ext4 / xfs) : "
        read fsxt
        mkfs.$fsxt /dev/$diskinput$bum
        mount /dev/$diskinput$bum /MOUNTS/$diskinput/$diskinput$bum
	bum=$(( $bum + 1))
	done
else
	echo " not found !! "
fi

echo " ALL DONE !!! "
echo " Check the command ( lsblk ) to make sure everything is done correctly ! "

############################################
