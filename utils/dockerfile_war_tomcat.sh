FROM public.ecr.aws/docker/library/tomcat:8.5.93-jdk8-corretto-al2

ADD arquivo.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
