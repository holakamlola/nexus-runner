FROM gitlab/gitlab-runner:latest

# Open port 80 for Render's mandatory public health check loop
EXPOSE 80

# Seed config.toml with the correct full university URL and Docker baseline setup
RUN mkdir -p /etc/gitlab-runner && \
    echo 'concurrent = 4' > /etc/gitlab-runner/config.toml && \
    echo 'check_interval = 3' >> /etc/gitlab-runner/config.toml && \
    echo 'listen_address = "0.0.0.0:80"' >> /etc/gitlab-runner/config.toml && \
    echo '[[runners]]' >> /etc/gitlab-runner/config.toml && \
    echo '  name = "Render-Free-Runner"' >> /etc/gitlab-runner/config.toml && \
    echo '  url = "https://rochester.edu"' >> /etc/gitlab-runner/config.toml && \
    echo '  id = 1' >> /etc/gitlab-runner/config.toml && \
    echo '  token = "glrt-t3_yNryqXxFsWGm6pGyyB3-"' >> /etc/gitlab-runner/config.toml && \
    echo '  executor = "docker"' >> /etc/gitlab-runner/config.toml && \
    echo '  [runners.custom_build_dir]' >> /etc/gitlab-runner/config.toml && \
    echo '  [runners.docker]' >> /etc/gitlab-runner/config.toml && \
    echo '    tls_verify = false' >> /etc/gitlab-runner/config.toml && \
    echo '    image = "alpine:latest"' >> /etc/gitlab-runner/config.toml && \
    echo '    privileged = false' >> /etc/gitlab-runner/config.toml && \
    echo '    disable_entrypoint_overwrite = false' >> /etc/gitlab-runner/config.toml && \
    echo '    oom_kill_disable = false' >> /etc/gitlab-runner/config.toml && \
    echo '    disable_cache = false' >> /etc/gitlab-runner/config.toml && \
    echo '    volumes = ["/cache"]' >> /etc/gitlab-runner/config.toml && \
    echo '    shm_size = 2000000000' >> /etc/gitlab-runner/config.toml && \
    echo '  [runners.cache]' >> /etc/gitlab-runner/config.toml && \
    echo '    MaxUploadedArchiveSize = 0' >> /etc/gitlab-runner/config.toml

# Clear entrypoint boundaries and launch system multi-runner run daemon loops
ENTRYPOINT []
CMD ["gitlab-runner", "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
