#!/bin/bash

set -e

if [[ ! -d "~/.bashrc.d" ]]; then
  mkdir -p ~/.bashrc.d
  
  touch ~/.bashrc.d/dummy.bash

  echo 'for file in ~/.bashrc.d/*.bash; do source "$file"; done' >> ~/.bashrc
fi

if [ ! -z "$CLOUD9_ENVIRONMENT_ID" ]; then
  echo "aws cloud9 update-environment --environment-id $CLOUD9_ENVIRONMENT_ID --managed-credentials-action DISABLE &> /dev/null || true" > ~/.bashrc.d/c9.bash
fi

echo 'export AWS_PAGER=""' > ~/.bashrc.d/aws.bash

touch ~/.bashrc.d/workshop-env.bash

cat << EOT > /home/ec2-user/.bashrc.d/aliases.bash
function prepare-environment() { bash /usr/local/bin/reset-environment \$1; source ~/.bashrc.d/workshop-env.bash; }

function use-cluster() { bash /usr/local/bin/use-cluster \$1; source ~/.bashrc.d/env.bash; }
EOT

if [ ! -z "$REPOSITORY_REF" ]; then
  echo "export REPOSITORY_REF='${REPOSITORY_REF}'" > ~/.bashrc.d/repository.bash
fi