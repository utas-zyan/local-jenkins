#! /bin/bash -e

: "${JENKINS_HOME:="/var/jenkins_home"}"
JENKINS_JOBS_FOLDER=${JENKINS_HOME}/jobs
# loop through folder and find all the job configs
find ${JENKINS_JOBS_FOLDER} -name "config.xml" -print0 | while IFS= read -r -d '' i; do
    folder=$(dirname "${i}")
    if [ ! -d "${folder}/jobs" ]; then
        echo "Found job folder ${folder}"
    else
        continue
    fi
    configfile="${folder}/config.xml"
    if [ ! -f "${configfile}" ]; then
        echo "Config file ${configfile} not found -- that is unusal"
        continue
    fi
    # Check if job is explicitly disabled
    if grep -q "<disabled>true</disabled>" "${configfile}" > /dev/null 2>&1; then
        echo "Job already disabled, skipping"
    elif grep -q "<disabled>false</disabled>" "${configfile}" > /dev/null 2>&1; then
        echo "Job explicitly enabled, disabling it"
        sed -i 's/<disabled>false/<disabled>true/g' "${configfile}"
    else
        echo "Job has no disabled tag, adding it as disabled"
        sed -i "\$i <disabled>true</disabled>\n" "${configfile}"
    fi
    
done
bash "/usr/local/bin/jenkins.sh"