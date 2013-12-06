require 'spec_helper'

describe 'logrotate::base' do
  it do
    should contain_package('logrotate').with_ensure('latest')

    should contain_file('/etc/logrotate.conf').with({
      'ensure'  => 'file',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0444',
      'require' => 'Package[logrotate]',
    })

    should contain_file('/etc/logrotate.d').with({
      'ensure'  => 'directory',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0755',
      'require' => 'Package[logrotate]',
    })

    should contain_file('/etc/cron.daily/logrotate').with({
      'ensure'  => 'file',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0555',
      'source'  => 'puppet:///modules/logrotate/etc/cron.daily/logrotate',
      'require' => 'Package[logrotate]',
    })
  end

  context 'for logrotate.conf source selection' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Ubuntu'} }

    it do
      should contain_file('/etc/logrotate.conf').with_source([
        'puppet:///modules/logrotate/etc/logrotate.conf.Ubuntu',
        'puppet:///modules/logrotate/etc/logrotate.conf.Debian',
        'puppet:///modules/logrotate/etc/logrotate.conf',
      ])
    end
  end

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }

    it { should contain_class('logrotate::defaults::debian') }
  end

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }

    it { should contain_class('logrotate::defaults::redhat') }
  end

  context 'on SuSE' do
    let(:facts) { {:osfamily => 'SuSE'} }

    it { should contain_class('logrotate::defaults::suse') }
  end

  context 'on Gentoo' do
    let(:facts) { {:operatingsystem => 'Gentoo'} }

    it { should contain_class('logrotate::defaults::gentoo') }
  end
end
