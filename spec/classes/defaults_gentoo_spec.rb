require 'spec_helper'

describe 'logrotate::defaults::gentoo' do
  it do
    should contain_logrotate__rule('wtmp').with({
      'rotate_every' => 'month',
      'rotate'       => '1',
      'create'       => true,
      'create_mode'  => '0664',
      'create_owner' => 'root',
      'create_group' => 'utmp',
      'minsize'      => '1M',
      'dateext'      => true,
      'compress'     => true,
      'ifempty'      => false,
      'mail'         => false,
      'olddir'       => false,
    })

    should contain_logrotate__rule('btmp').with({
      'rotate_every' => 'month',
      'rotate'       => '1',
      'create'       => true,
      'create_mode'  => '0660',
      'create_owner' => 'root',
      'create_group' => 'utmp',
      'missingok'    => true,
      'dateext'      => true,
      'compress'     => true,
      'ifempty'      => false,
      'mail'         => false,
      'olddir'       => false,
    })
  end
end
