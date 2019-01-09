docker build -t stellar-account-viewer .
docker run -i -t stellar-account-viewer /bin/bash

# run the following inside of the Docker container:
# ./node_modules/.bin/interstellar build --env=prd
