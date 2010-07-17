
sub githubmeta  { warn 'You need Module::Install::GithubMeta installed' }
sub extra_tests { warn 'You need Module::Install::ExtraTests installed' }

use inc::Module::Install;

githubmeta;

my $master = 'lib/Catalyst/TraitFor/Request/IsRESTy.pm';

name     'Catalyst-TraitFor-Request-IsRESTy';
all_from $master;
author   q{Chris Weyl <cweyl@alumni.drew.edu>};
license  'lgpl';

readme_from $master;
readme_markdown_from $master;

requires 'namespace::autoclean' => '0.09';
requires 'Catalyst::Controller::Resources' => '0.08';

# strictly speaking, we don't absolutely need this...  but we're not going to
# be very useful without it
requires 'CatalystX::RoleApplicator';

test_requires 'Test::More';
author_requires 'File::Find::Rule';
author_requires 'Module::ScanDeps';

extra_tests;
auto_install;
auto_provides;
write_mymeta_json;

WriteAll;

