FROM gitlab/gitlab-runner:latest

# Set the environment setup fields
ENV CI_SERVER_URL="https://rochester.edu"
ENV RUNNER_TOKEN="glrt-t3_yNryqXxFsWGm6pGyyB3-"

# Expose web port for Render's health tier checks
EXPOSE 80

# Override entrypoint to force bash processing
ENTRYPOINT ["/bin/bash", "-c"]

# Run the registration pipeline and spin up the web framework at startup
CMD ["gitlab-runner register --non-interactive --url \"${CI_SERVER_URL}\" --token \"${RUNNER_TOKEN}\" --executor \"shell\" --description \"Render-Free-Runner\" && echo 'Runner Active' > index.html && python3 -m http.server 80"]
