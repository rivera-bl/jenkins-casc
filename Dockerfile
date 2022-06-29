# TODO pin version
FROM jenkins/jenkins:latest

###################################################################
## CASC
###################################################################

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

COPY --chown=jenkins:jenkins jenkins-home/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

COPY casc.yaml /var/jenkins_home/casc.yaml

###################################################################
## JOB DSL
###################################################################

ENV JENKINS_REF /usr/share/jenkins/ref

COPY jenkins-home/jobs $JENKINS_REF/jobs/
COPY jenkins-home/init.groovy.d $JENKINS_REF/init.groovy.d/
COPY jenkins-home/dsl $JENKINS_REF/dsl/
