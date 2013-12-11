#!/usr/bin/perl -w

use strict;
use warnings;
use Env qw (PATH PERL5LIB DOCUMENT_ROOT QUERY_STRING REQUEST_METHOD);
use CGI qw(:standard);

print "<html>\n";

print "<head>\n";

print "<title>Perl Executing Browser - Test Results</title>\n";
print "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>\n";

print "</head>\n";

print "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>\n";

print "<p align='center'><font size='5' face='SansSerif'>\n";
print "Test Results\n";
print "</font></p>\n";

print "<p align='left'><font size='3' face='SansSerif'>\n";
print "<a href='local://script/index.pl'>Back to the dynamic startpage</a>\n";
print "</font></p>\n";

print "<p align='left'><font size='3' face='SansSerif'>\n";
print "<a href='local://script/index.htm'>Back to the static startpage</a>\n";
print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "FILE AND FOLDER TO OPEN:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";
if (defined @ARGV){
	my ($file, $folder) = @ARGV;
	print "\$ARGV[0] - FILE: $file<br>\n";
	print "\$ARGV[1] - FOLDER: $folder<br>\n";
}
print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "FORM DATA:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";
my %form;
foreach my $p (param()) {
	$form{$p} = param($p);
	print "$p = $form{$p}<br>\n";
}
print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "MODIFIED AND NEW ENVIRONMENT VARIABLES:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";
if (defined $PATH){
	print "PATH = $PATH<br>\n";
}
if (defined $PERL5LIB){
	print "PERL5LIB = $PERL5LIB<br>\n";
}
if (defined $DOCUMENT_ROOT){
	print "DOCUMENT_ROOT = $DOCUMENT_ROOT<br>\n";
}
if (defined $QUERY_STRING){
	print "QUERY_STRING = $QUERY_STRING<br>\n";
}
if (defined $REQUEST_METHOD){
	print "REQUEST_METHOD = $REQUEST_METHOD<br>\n";
}
print "</font></p>\n";

print "<p align='left'><font size='4' face='SansSerif'>\n";
print "ALL ENVIRONMENT VARIABLES:\n";
print "</font></p>\n";
print "<p align='left'><font size='3' face='SansSerif'>\n";
foreach my $key (sort(keys(%ENV))) {
	print "$key = $ENV{$key}<br>\n";
}
print "</font></p>\n";

print "</body>\n";
print "</html>\n";