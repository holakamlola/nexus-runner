FROM gitlab/gitlab-runner:latest

# Set the correct environment variables
ENV CI_SERVER_URL="https://rochester.edu"
ENV RUNNER_TOKEN="glrt-t3_yNryqXxFsWGm6pGyyB3-"

# Authenticate using the modern --token flag
RUN gitlab-runner register \
  --non-interactive \
  --url "${CI_SERVER_URL}" \
  --token "${RUNNER_TOKEN}" \
  --executor "shell" \
  --description "Render-Free-Runner"

# Expose web port for Render's tier check
EXPOSE 80
CMD ["sh", "-c", "echo 'Runner Active' > index.html && exec python3 -m http.server 80"]
