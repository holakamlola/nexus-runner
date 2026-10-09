FROM gitlab/gitlab-runner:latest

# Set the environment setup fields
ENV CI_SERVER_URL="https://rochester.edu"
ENV RUNNER_TOKEN="glrt-t3_yNryqXxFsWGm6pGyyB3-"

# Expose web port for Render's tier check
EXPOSE 80

# Run the registration AND start the web server/runner at runtime boot up
CMD ["sh", "-c", "\
  gitlab-runner register \
    --non-interactive \
    --url \"${CI_SERVER_URL}\" \
    --token \"${RUNNER_TOKEN}\" \
    --executor \"shell\" \
    --description \"Render-Free-Runner\" && \
  echo 'Runner Active' > index.html && \
  python3 -m http.server 80 \
"]
