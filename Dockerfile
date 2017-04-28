FROM tomcat:7.0.77-jre8-alpine
LABEL maintainer mark.speich@siriuscom.com
RUN rm -rf /usr/local/tomcat/webapps/ROOT
ADD JPetStore.war /usr/local/tomcat/webapps/ROOT.war
