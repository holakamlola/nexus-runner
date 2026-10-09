FROM gitlab/gitlab-runner:latest

# Open port 80 for Render's mandatory public health check loop
EXPOSE 80

# Seed config.toml with the CORRECT full university URL path and shell executor
RUN mkdir -p /etc/gitlab-runner && \
    echo 'concurrent = 4' > /etc/gitlab-runner/config.toml && \
    echo 'check_interval = 3' >> /etc/gitlab-runner/config.toml && \
    echo 'listen_address = "0.0.0.0:80"' >> /etc/gitlab-runner/config.toml && \
    echo '[[runners]]' >> /etc/gitlab-runner/config.toml && \
    echo '  name = "Render-Free-Runner"' >> /etc/gitlab-runner/config.toml && \
    echo '  url = "https://gitlab-public.circ.rochester.edu/"' >> /etc/gitlab-runner/config.toml && \
    echo '  id = 1' >> /etc/gitlab-runner/config.toml && \
    echo '  token = "glrt-t3_yNryqXxFsWGm6pGyyB3-"' >> /etc/gitlab-runner/config.toml && \
    echo '  executor = "shell"' >> /etc/gitlab-runner/config.toml

# Clear entrypoint boundaries and launch system runner run daemon loops
ENTRYPOINT []
CMD ["gitlab-runner", "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
