FROM tomcat:7.0.77-jre8-alpine
LABEL maintainer mark.speich@siriuscom.com
ADD JPetStore.war /usr/local/tomcat/webapps/ROOT.war
ADD context.xml /usr/local/tomcat/conf/