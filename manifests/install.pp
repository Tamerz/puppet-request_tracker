# request_tracker::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include request_tracker::install
class request_tracker::install inherits request_tracker {

  $packages = ['gcc', 'httpd', 'git', 'perl-CPAN']

  package { $packages: }

  archive { "/tmp/rt-${request_tracker::version}.tar.gz":
    ensure        => present,
    extract       => true,
    extract_path  => '/tmp',
    source        => "https://download.bestpractical.com/pub/rt/release/rt-${request_tracker::version}.tar.gz",
    checksum      => $request_tracker::checksum,
    checksum_type => 'sha256',
    creates       => "/tmp/rt-${request_tracker::version}",
    cleanup       => true,
  }

  exec { 'configure':
    command => "/tmp/rt-${request_tracker::version}/configure --enable-graphviz --enable-gd --enable-externalauth",
    cwd     => "/tmp/rt-${request_tracker::version}",
    require => Archive["/tmp/rt-${request_tracker::version}.tar.gz"],
  }

}
