# Container image that runs your code
FROM astronutsapp/hubble-scanner:latest

LABEL "com.github.actions.name"="Astronuts Code Quality Check"
LABEL "com.github.actions.description"="Run Astronuts code quality checks."
LABEL "com.github.actions.icon"="bar-chart-2"
LABEL "com.github.actions.color"="white"

LABEL version="0.0.1"
LABEL repository="https://github.com/astronuts-app/astronuts-code-quality-action"
LABEL homepage="https://astronuts.io"
LABEL maintainer="astronuts-app"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


