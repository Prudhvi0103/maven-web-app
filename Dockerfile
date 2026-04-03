FROM tomcat:9-jdk17

LABEL maintainer="Prudhvi"

# Remove default apps (optional but clean)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file
COPY target/maven-web-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080
