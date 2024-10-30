HERE=$(cd $(dirname $0); pwd)
source $HERE/common.sh
# rsync -avrl "jenkins-diginonprod:$WORKING_FOLDER/jenkins_data_part_*" . 

# cat jenkins_data_part_* > jenkins_data.tar.gz.enc
# openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 100000 -in jenkins_data.tar.gz.enc -out jenkins_data.tar.gz

mkdir -p jenkins_data && tar vfxz jenkins_data.tar.gz -C jenkins_data

