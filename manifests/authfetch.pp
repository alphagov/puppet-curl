################################################################################
# Definition: curl::authfetch
#
# This class will download files from the internet.  You may define a web proxy
# using $http_proxy or $https_proxy if necessary. Username must be provided. 
# And the user's password must be stored in the password variable within the
# .curlrc file.
################################################################################
define curl::authfetch(
    $source,
    $destination,
    $user,
    $options="",
    $password="",
    $timeout="0",
    $verbose=false) {
        
  include curl
  include stdlib

  if $::http_proxy {
    $env1 = [ "HTTP_PROXY=$::http_proxy", "http_proxy=$::http_proxy" ]
  }
  else {
    $env1 = []
  }

  if $::https_proxy {
    $env2 = [ "HTTPS_PROXY=$::https_proxy", "https_proxy=$::https_proxy" ]
  }
  else {
    $env2 = []
  }


  $verbose_option = $verbose ? {
    true  => "--verbose",
    false => "--silent --show-error"
  }

  file { "/tmp/curlrc-$name":
    owner   => root,
    mode    => "0600",
    content => "user = $user:$password",
  } ->
  exec { "curl-$name":
    command     => "curl $verbose_option $options --config /tmp/curlrc-$name --output $destination $source",
    timeout     => $timeout,
    unless      => "test -s $destination",
    environment => concat($env1, $env2),
    path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/local/bin",
    require     => Class[curl],
  }
}

