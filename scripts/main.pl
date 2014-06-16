#!/usr/bin/perl -w

# UTF-8 encoded file

use strict;
use warnings;

print "Content-type: text/html; charset=utf-8\n\n";

print <<HTML
<html>

<head>
<title>Perl Executing Browser - Dynamic Startpage</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
</head>

<body>

<div class="container">
<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun_perlinfo.pl?theme=disabled'>Perl Info</a>
</font><br>
<font size='3'>
Non-core module loaded from directory, without system-wide installation.<br>
<a href='http://search.cpan.org/dist/HTML-Perlinfo/lib/HTML/Perlinfo/HTML.pod'>http://search.cpan.org/dist/HTML-Perlinfo/lib/HTML/Perlinfo/HTML.pod</a><br>
Copyright (c) 2009, Michael Accardo
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/env.pl'>Perl Environment Test</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl'>Perl SQLite Example</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/sqlite.pl?source=enabled' target='_blank'>Perl SQLite Example as source code</a>
</font><br>
<font size='3'>
(will open in a new window)
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/timeout_test.pl'>Script Timeout Test</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/phpinfo.php?theme=disabled'>phpinfo()</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/env.py'>Python Environment Test</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/cgi-test.py'>Python CGI Example</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/main.pl' target='_blank'>Dynamic Start Page in a New Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/index.htm' target='_blank'>Static Start Page in a New Window</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/get.htm'>Form of a Locally Executed Perl Script - GET method</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/post.htm'>Form of a Locally Executed Perl Script - POST method</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='file:///home/knoppix/github/peb/peb.ini'>External Document</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='external:/gedit peb.ini'>External Program with an Argument</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='https://www.google.com/doodles/finder/'>Allowed External Link Nr.1 in This Browser</a>
</font></p>

<p align='center'><font size='5'>
<a href='https://www.google.com/doodles/finder/' target='_new'>Allowed External Link Nr.1 in a New Window of This Browser</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://www.perl.org/cpan.html'>Allowed External Link Nr.2 in This Browser</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://www.perl.org/cpan.html' target='_new'>Allowed External Link Nr.2 in a New Window of This Browser</a>
</font></p>

<p align='center'><font size='5'>
<button onclick='allowedContent()' class='btn btn-primary'>Open Allowed Content in a New Window from JavaScript</button>
</font></p>

<script>
function allowedContent() {
	window.open ('https://www.google.bg');
}
</script>

<p align='center'><font size='5'>
<button onclick='notAllowedContent()' class='btn btn-primary'>Not Allowed Content in a New Window from JavaScript - Blocked</button>
</font></p>

<script>
function notAllowedContent() {
	window.open ('http://www.yahoo.com');
}
</script>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='https://www.microsoft.com/'>Not Allowed External Link in Default Browser</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='selectperl://now'>Select Perl Interpreter</a>
</font></p>

<p align='center'><font size='5'>
<a href='selectpython://now'>Select Python Interpreter</a>
</font></p>

<p align='center'><font size='5'>
<a href='selectphp://now'>Select PHP Interpreter</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='selecttheme://now'>Select Browser Theme</a>
</p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='newfile://now'>Create New File</a>
</font></p>

<p align='center'><font size='5'>
<a href='openfile://now'>Open Existing File</a>
</font></p>

<p align='center'><font size='5'>
<a href='openfolder://now'>Open Existing Folder or Create a New One</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='perl_debugger_list_modules://now'>List All Modules of a Perl Script using<br>Built-in Perl Debugger</a>
</font></p>

<p align='center'><font size='5'>
<a href='perl_debugger_list_subroutine_names://now'>List All Subroutine Names of a Perl Script using<br>Built-in Perl Debugger</a>
</font></p>

<p align='center'><font size='5'>
<a href='perl_debugger_list_variables_in_package://now'>List All Variables of a Perl Script using<br>Built-in Perl Debugger</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='print://now'>Print</a>
</font></p>

<p align='center'><font size='5'>
<a href='printpdf://now'>Save as PDF</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='http://localhost:8080'>Localhost</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl?output=latest'>Long-Running Script in This Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/scripts/longrun.pl?output=latest' target='_blank'>Long-Running Script in a New Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='http://perl-executing-browser-pseudodomain/html/resizer.htm'>Resizer Long Running Example</a>
</font></p>

<hr width='95%'>

<p align='center'><font size='5'>
<a href='closewindow://now'>Close Window</a>
</font></p>

<p align='center'><font size='5'>
<a href='quit://now'>Quit Application</a>
</font></p>

</div>
</body>

</html>
HTML
;