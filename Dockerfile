FROM jenkins/jenkins:latest
# disables the setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# sets the location of the casc config
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
# copies the file with the list of plugins to install
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
# runs the install plugins script
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
# copies the casc (url setup) on the location for the ENV of CASC
COPY casc.yaml /var/jenkins_home/casc.yaml
