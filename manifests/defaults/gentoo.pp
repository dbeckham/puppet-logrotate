# Internal: Manage the default gentoo logrotate rules.
#
# Examples
#
#   include logrotate::defaults::gentoo
class logrotate::defaults::gentoo {
  Logrotate::Rule {
    rotate_every => 'month',
    create       => true,
    create_owner => 'root',
    create_group => 'utmp',
    rotate       => 1,
    dateext      => true,
    compress     => true,
    ifempty      => false,
    mail         => false,
    olddir       => false
  }

  logrotate::rule {
    'wtmp':
      path        => '/var/log/wtmp',
      create_mode => '0664',
      minsize     => '1M';
    'btmp':
      path        => '/var/log/btmp',
      missingok   => true,
      create_mode => '0660';
  }
}
