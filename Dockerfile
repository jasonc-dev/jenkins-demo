FROM jenkins/jenkins:2.303.3-jdk11

#USER root
#RUN curl -sSL https://get.docker.com/ | sh
#RUN usermod -a -G docker jenkins
#USER jenkins

USER root
RUN apt-get update
RUN curl -fsSL https://get.docker.com/ | sh
RUN usermod -aG docker root
RUN newgrp root
USER root

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY seedJob.xml /usr/share/jenkins/ref/jobs/seed-job/config.xml

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false