package MyApp::Dummy;
use Moose;

with 'MyApp::Role::ClassConfig' => {
	attributes => [
		'username', 'auth',
	]
};

1;
