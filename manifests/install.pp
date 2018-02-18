# request_tracker::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include request_tracker::install
class request_tracker::install inherits request_tracker {

  package { 'gcc': }

  archive { "/tmp/rt-${version}.tar.gz":
    ensure        => present,
    extract       => true,
    extract_path  => '/tmp',
    source        => "https://download.bestpractical.com/pub/rt/release/rt-${version}.tar.gz",
    checksum      => $checksum,
    checksum_type => 'sha256',
    creates       => "/tmp/rt-${version}",
    cleanup       => true,
  }

}
