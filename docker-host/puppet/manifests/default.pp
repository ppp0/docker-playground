node default {

  require 'apt::transport_https'
  require 'apt::source::cargomedia'


  install_docker_cmd = 'if $(which docker); then exit 0;fi;

  wget -q -O - https://get.docker.io/gpg | apt-key add -;'
"echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list;" \
"apt-get update -qq; apt-get install -q -y --force-yes lxc-docker; "
  # Add vagrant user to the docker group
install_docker_cmd << "usermod -a -G docker vagrant; "
END

exec { 'install docker':
provider    => shell,
command     => "for i in ${base_dirs}; do mkdir -p \$i; done",
unless      => "for i in ${base_dirs}; do if ! [ -d \$i ]; then exit 1; fi; done",
path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
}


}
