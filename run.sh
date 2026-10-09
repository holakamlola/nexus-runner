#!/bin/bash

# Start Render's required background web server helper
echo 'Runner Active' > index.html
python3 -m http.server 80 &

# Start the actual GitLab runner daemon process
exec gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner
