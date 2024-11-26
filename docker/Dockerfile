FROM jenkins/jenkins:latest


COPY ca-bundle.trust.crt ca-bundle.crt /usr/local/share/ca-certificates/

USER root
RUN /usr/sbin/update-ca-certificates

RUN keytool -storepass changeit -importcert -noprompt -trustcacerts -file  "/etc/ssl/certs/ca-certificates.crt" --alias ca-certs --keystore /opt/java/openjdk/lib/security/cacerts

COPY jenkins_wrapper.sh /usr/local/bin/
USER jenkins
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins_wrapper.sh"]