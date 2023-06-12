# Container image that runs your code
FROM astronutsapp/astronuts-cq-scanner:latest
#VOLUME /Users/arunkpatra/codebase/sonar-build/test-sonar
# Copies your code file from your action repository to the filesystem path `/` of the container
#COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
#ENTRYPOINT ["/entrypoint.sh"]


