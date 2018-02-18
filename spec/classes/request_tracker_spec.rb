require 'spec_helper'

describe 'request_tracker' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          version: '4.4.2',
          checksum: 'b2e366e18c8cb1dfd5bc6c46c116fd28cfa690a368b13fbf3131b21a0b9bbe68',
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_package('gcc') }
      it { is_expected.to contain_package('httpd') }
      it { is_expected.to contain_package('git') }
      it { is_expected.to contain_package('perl-cpan') }
      it {
        is_expected.to contain_archive('/tmp/rt-4.4.2.tar.gz').with(
          'ensure'        => 'present',
          'extract'       => true,
          'extract_path'  => '/tmp',
          'source'        => 'https://download.bestpractical.com/pub/rt/release/rt-4.4.2.tar.gz',
          'checksum'      => 'b2e366e18c8cb1dfd5bc6c46c116fd28cfa690a368b13fbf3131b21a0b9bbe68',
          'checksum_type' => 'sha256',
          'creates'       => '/tmp/rt-4.4.2',
          'cleanup'       => true,
        )
      }
      it {
        is_expected.to contain_exec('configure').with(
          'command' => '/tmp/rt-4.4.2/configure --enable-graphviz --enable-gd --enable-externalauth',
          'cwd'     => '/tmp/rt-4.4.2',
        ).that_requires('Archive[/tmp/rt-4.4.2.tar.gz]')
      }
    end
  end
end
