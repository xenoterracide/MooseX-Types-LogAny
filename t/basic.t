use strict;
use warnings;
use Test::More;
use Class::Load 0.20 'load_class';
use Test::Fatal;

{
	package Test;
	use Moose;
	use Class::Load 'load_class';
	use MooseX::Types::LogAny qw( LogAny );

	has log => (
		isa => LogAny,
		is  => 'rw',
	);
}

my $t = new_ok( load_class('Test') );

load_class('Log::Any::Adapter')->set('Null');

my $e0 = exception { $t->log( load_class('Log::Any')->get_logger ) };

ok ! $e0, 'using null logger does not throw an exception';

load_class('Log::Any::Adapter')->set('Stderr');

my $e1 = exception { $t->log( load_class('Log::Any')->get_logger ) };

ok ! $e1, 'using sterr logger does not throw an exception';

done_testing;
