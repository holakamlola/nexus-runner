FROM gitlab/gitlab-runner:latest

# Expose web port for Render's tier check
EXPOSE 80

# Manually create the GitLab Runner configuration layout
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
    echo '  token_obtained_at = 2026-10-09T00:00:00Z' >> /etc/gitlab-runner/config.toml && \
    echo '  token_expires_at = 0001-01-01T00:00:00Z' >> /etc/gitlab-runner/config.toml && \
    echo '  executor = "shell"' >> /etc/gitlab-runner/config.toml && \
    echo '  [runners.custom_build_dir]' >> /etc/gitlab-runner/config.toml && \
    echo '  [runners.cache]' >> /etc/gitlab-runner/config.toml && \
    echo '    MaxUploadedArchiveSize = 0' >> /etc/gitlab-runner/config.toml

# Boot up the background health check app alongside the official system runner entrypoint
CMD ["sh", "-c", "echo 'Runner Active' > index.html && python3 -m http.server 80 & exec gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner"]
