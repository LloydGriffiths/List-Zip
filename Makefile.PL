use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'List::Zip',
    VERSION_FROM     => 'lib/List/Zip.pm',
    AUTHOR           => 'Lloyd Griffiths (lloydg@cpan.org)',
    ABSTRACT         => 'Module to zip lists',
    LICENSE          => 'perl',
    MIN_PERL_VERSION => '5.006000',
    PREREQ_PM  => {
        'parent'       => 0,
        'Test::Simple' => 0.44,
    },
    META_MERGE => {
        resources => {
            repository => 'https://github.com/LloydGriffiths/List-Zip',
        },
    },
);
