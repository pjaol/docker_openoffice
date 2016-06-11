FROM ubuntu:14.04
MAINTAINER pjaol

RUN apt-get update

RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN add-apt-repository ppa:erinnerungsfragment/monit 
RUN apt-get update
RUN apt-get install -y monit
RUN apt-get install -y unzip
RUN \

  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && apt-get install -y oracle-java7-installer
	
RUN apt-get install -y libxt6
RUN apt-get install -y libxext6
RUN apt-get install -y libfreetype6
RUN apt-get install -y libxrender1
ADD http://downloads.sourceforge.net/project/openofficeorg.mirror/4.1.2/binaries/en-US/Apache_OpenOffice_4.1.2_Linux_x86-64_install-deb_en-US.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fopenofficeorg.mirror%2Ffiles%2F4.1.2%2Fbinaries%2Fen-US%2F&ts=1465503792&use_mirror=nbtelecom Apache_OpenOffice_4.1.1_Linux_x86-64_install-deb_en-US.tar.gz
ADD http://downloads.sourceforge.net/project/jodconverter/JODConverter/2.2.2/jodconverter-webapp-2.2.2.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fjodconverter%2Ffiles%2FJODConverter%2F2.2.2%2F&ts=1465518105&use_mirror=liquidtelecom jodconverter-webapp-2.2.1.zip

# Used for local dev
#COPY jodconverter-webapp-2.2.2.zip /
#COPY Apache_OpenOffice_4.1.1_Linux_x86-64_install-deb_en-US.tar.gz /

COPY start_oo.sh /

# Use monit to manage tomcat - container should die if soffice fails 
COPY tomcat_monit /etc/monit/conf.d/


RUN tar -xvzf Apache_OpenOffice*.tar.gz
RUN dpkg -i en-US/DEBS/*.deb
RUN dpkg -i en-US/DEBS/desktop-integration/*.deb
RUN apt-get install -y oracle-java7-installer
RUN apt-get install -y tomcat7
RUN apt-get install -y unzip
RUN unzip jodconverter-webapp-2.2.2.zip jodconverter-webapp-2.2.2/jodconverter-webapp-2.2.2.war
RUN cp jodconverter-webapp-2.2.2/jodconverter-webapp-2.2.2.war /var/lib/tomcat7/webapps/convert.war

CMD [/start_oo.sh]