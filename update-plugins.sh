mkdir jenkins_data_temp
( cd jenkins_data_temp
curl -L https://updates.jenkins.io/download/plugins/mailer/489.vd4b_25144138f/mailer.hpi -O
# curl -L https://github.com/chekist32/2fa-plugin-jenkins/releases/download/v1.0.2/2fa-jenkins-plugin-1.0.2.hpi -O
)
mv jenkins_data_temp/* jenkins_data/plugins && rm -rf jenkins_data_temp
