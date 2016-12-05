################################################################################
# Class: curl
#
# This class will install curl - a tool used to download content from the web.
#
################################################################################
class curl($version='installed') {

  ensure_packages(['curl'], {
    'ensure' => $version,
  })

}
