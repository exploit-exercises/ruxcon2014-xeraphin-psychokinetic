#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $self = shift;
  $self->render('index');
};

post '/ping' => sub {
  my $self = shift;
  my $host = $self->param('host');

  my $result = "";

  open(my $PS, "host $host 2>&1 |") || return $self->render(text => "Failed to ping !");

  while(<$PS>) {
    $result .= $_;
  };

  $self->render(text => $result);
};

app->start;
app->secrets(['e3e52e0b-25cc-4063-b00c-c4b914f41812']);
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<form method="POST" action="/ping">
  <p>Host to perform DNS lookup for</p>
  <input type="text" name="host" value="slashdot.org"/><br/>
  <input type="submit" name="submit" value="submit"/>
</form>

@@ response.html.ep
% layout 'default';
% title 'Your results';

<%= results =>
  
@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>


