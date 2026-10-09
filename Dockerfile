FROM gitlab/gitlab-runner:latest

# Expose web port for Render's tier check
EXPOSE 80

# Manually create the GitLab Runner configuration properties
RUN mkdir -p /etc/gitlab-runner && \
    echo 'concurrent = 1' > /etc/gitlab-runner/config.toml && \
    echo 'check_interval = 0' >> /etc/gitlab-runner/config.toml && \
    echo '[session_server]' >> /etc/gitlab-runner/config.toml && \
    echo '  session_timeout = 1800' >> /etc/gitlab-runner/config.toml && \
    echo '[[runners]]' >> /etc/gitlab-runner/config.toml && \
    echo '  name = "Render-Free-Runner"' >> /etc/gitlab-runner/config.toml && \
    echo '  url = "https://rochester.edu"' >> /etc/gitlab-runner/config.toml && \
    echo '  id = 1' >> /etc/gitlab-runner/config.toml && \
    echo '  token = "glrt-t3_yNryqXxFsWGm6pGyyB3-"' >> /etc/gitlab-runner/config.toml && \
    echo '  executor = "shell"' >> /etc/gitlab-runner/config.toml

# Copy the custom boot script into the container and make it executable
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Reset the broken default image entrypoint and execute our script directly
ENTRYPOINT []
CMD ["/bin/bash", "/run.sh"]
