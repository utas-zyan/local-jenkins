HERE=$(cd $(dirname $0); pwd)
source $HERE/common.sh
cd $WORKING_FOLDER

mkdir -p backup/plugins

sudo bash -c 'rsync -avrld /data/jenkins_home/ \
   --exclude jobs --exclude logs \
   --exclude workspace --exclude caches \
   --exclude plugins_ec2working --exclude org.jenkinsci.plugins.github_branch_source.GitHubSCMProbe.cache \
   --exclude plugins \
   --exclude config-history \
   backup
cp /data/jenkins_home/plugins/*.jpi backup/plugins/
tar -czvf jenkins_data.tar.gz -C backup .'
openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in jenkins_data.tar.gz -out jenkins_data.tar.gz.enc && rm -rf jenkins_data.tar.gz
split -C 100M jenkins_data.tar.gz.enc jenkins_data_part_
