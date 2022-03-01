set -o errexit -o noclobber -o nounset -o pipefail -o xtrace
shopt -s failglob inherit_errexit

postgresql_version="$1"

export DEBIAN_FRONTEND=noninteractive

# Allow PostgreSQL service to start
set +o noclobber
echo exit 0 > /usr/sbin/policy-rc.d
set -o noclobber

apt-get update
apt-get --assume-yes install "postgresql-${postgresql_version}-pgtap" "postgresql-server-dev-${postgresql_version}"

su --command='createuser --superuser root' postgres