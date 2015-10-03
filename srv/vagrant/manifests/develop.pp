# -*- mode: ruby -*-
# vi: set ft=ruby :

group { 'puppet': ensure => present }

Exec { environment => [ "HOME=/home/vagrant" ] }

file { "/home/vagrant/corretgecom":
    ensure => "directory",
    owner  => "vagrant",
    group  => "vagrant",
    mode   => 775,
}

class {'apt':
  update => {
    frequency => 'daily',
  },
}

package {
    [
        'vim',
        'htop',
        'tree',
        'mc',
        'virtualbox-guest-utils',
        'libfann-dev',
        'php5-cli',
        'php5-dev',
        'php-pear',
        'git',
        'curl',

    ]:
    ensure => 'latest'
}


class { 
	[
		'php',
		'php::extension::intl',
		'php::extension::curl',
		'php::composer',
		'php::composer::auto_update',
		'php::extension::xdebug'
	]:
    before => Exec['composer_config']
}

php::config {
	'output_buffering=0':
	file => '/etc/php5/cli/php.ini',
	require => Package['php5-cli']
} 

php::config { 'opcache.enable_cli=1':
    file    => '/etc/php5/cli/conf.d/05-opcache.ini',
    require   => Package['php5-cli']
}

php::config {
	[ 
	    'xdebug.remote_host=10.10.10.1', 
	    'xdebug.remote_port=9010', 
	    'xdebug.remote_enable=1',
	    'xdebug.remote_autostart=1',
	    'xdebug.remote_handler=dbgp',
	    'xdebug.remote_log=/tmp/log/xdebug.log',
	    'xdebug.idekey=netbeans-xdebug'
	]:
    file    => '/etc/php5/cli/conf.d/20-xdebug.ini',
    section => 'xdebug',
    require   => Package['php5-cli']
}

exec { "pecl install fann":
        require => Package["php-pear"]
}

exec {'composer_config':
    command => '/usr/local/bin/composer config -g github-oauth.github.com f0a71c9745759dd6ca7b4dc45355d5d407dc9667',
    environment => 'HOME=/home/vagrant',
    cwd => '/home/vagrant',
    user => 'vagrant',
    logoutput => true,
    require   => Package['php5-cli']
}

exec { 'corretgecom_install':
    command     => '/home/vagrant/corretgecom/srv/vagrant/install_dev.sh',
    user        => 'vagrant',
    cwd         => '/home/vagrant/corretgecom',
    logoutput   => true,
    timeout     => 1800,
    require     => Exec['composer_config']
}

