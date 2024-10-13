# Container image that runs your code
FROM astronutsapp/hubble-scanner:astronuts-ai-action-fix


LABEL "com.github.actions.name"="Astronuts Code Quality Check"
LABEL "com.github.actions.description"="Run Astronuts code quality checks."
LABEL "com.github.actions.icon"="bar-chart-2"
LABEL "com.github.actions.color"="white"

LABEL version="0.0.1"
LABEL repository="https://github.com/astronuts-app/astronuts-code-quality-action"
LABEL homepage="https://www.astronuts.io"
LABEL maintainer="astronuts-app"

# Install yq for YAML parsing
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq \

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script has execute permissions
RUN chmod +x /entrypoint.sh
# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]