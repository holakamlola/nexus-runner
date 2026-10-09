FROM gitlab/gitlab-runner:latest

# Set the environment setup fields
ENV CI_SERVER_URL="https://rochester.edu"
ENV REGISTRATION_TOKEN="glrt-t3_yNryqXxFsWGm6pGyyB3-"

# Automatically authenticate the worker immediately on boot
RUN gitlab-runner register \
  --non-interactive \
  --url "${CI_SERVER_URL}" \
  --registration-token "${REGISTRATION_TOKEN}" \
  --executor "shell" \
  --description "Render-Free-Runner"

# Render Free Tier requires an exposed web port to verify deployment.
# We run a small background ping check to keep Render satisfied.
EXPOSE 80
CMD ["sh", "-c", "echo 'Runner Active' > index.html && exec python3 -m http.server 80"]
