#!/bin/bash
echo install jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add - 
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ &gt; /etc/apt/sources.list.d/jenkins.list'
sudo aptitude update
sudo aptitude install jenkins

echo stop jenkins
service jenkins stop

# update jenkins
echo update jenkins
rm -f /usr/share/jenkins/jenkins.war.backup
cp /usr/share/jenkins/jenkins.war /usr/share/jenkins/jenkins.war.backup
rm -f jenkins.war
wget -q -P http://mirrors.jenkins-ci.org/war/latest/jenkins.war /usr/share/jenkins/

# copy cloudy job
# sudo apt-get upgrade

echo install plugins
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/violations.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/warnings.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/analysis-core.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/dry.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/ant.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/git.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/tasks.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/heroku-jenkins-plugin.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/github.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/github-api.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/compact-columns.hpi
wget -q -P /var/lib/jenkins/plugins http://updates.jenkins-ci.org/latest/tmpcleaner.hpi

echo start jenkins
service jenkins start

echo fix permissions issue with WEB-INF/cfclasses
sudo chmod 777 /opt/coldfusion10/cfusion/wwwroot/WEB-INF/cfclasses/