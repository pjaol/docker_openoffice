# docker_openoffice
## An Dockerized version of headless openoffce with JODConverter Webapp
Generally used to convert MicroSoft Office or OpenOffice documents to PDF
Check out JODConverter details from http://www.artofsolving.com/opensource/jodconverter.html

This docker image provides both OpenOffice and the JODConverter webapp that can be used as a REST application.
Open Office has a memory leak in headless mode that has not been fixed in nearly a decade, the easiest thing to do
is mitigate the issue using something like docker + mesos to allow for high availability or fault tolerance.

## To Build
Checkout this repo git clone https://github.com/pjaol/docker_openoffice.git
docker built -t oo .

## To Run
docker run -d -p 8080:8080 oo

Using a browser go to http://[docker-machine-ip]:8080/convert/

To use as an API view the JODConvert documentation for webapp usage
http://www.artofsolving.com/node/15.html

