#!/usr/bin/env perl -w
use Net::Ping;

# Asks the user to input the ip address of the device, and sets that
# as the value of $host
print "What IP would you like me to check? ";
$host = <STDIN>;
chomp($host);

print "What would you like to call this device? ";
$devName = <STDIN>;
chomp($devName);
$devName =~ s/ /_/g;
print "devName is $devName";


# Sets the value of $filename to printresults.txt, opens it for writing
# as RESULTs and sets it to flush the buffer automatically rather than
# when it's full. Otherwise it doesn't write to the file
$filename = "$devName.txt";
open (RESULTS, '>>', $filename) or die "dying at line 10";
RESULTS->autoflush( 1 );


# Prints hello to the file to test writing
print RESULTS "This is the monitor log for $devName\n with an IP of $host\n\n" or die "can't write to file";


$timeout=5;

# Reminds the user what IP they're going to monitor
print "You are going to monitor $host \n \n";


#Begins the monitoring loop
for( ; ; ) {

# Pings the selected IP and returns a value which can be interpreted
# as true (1) or false (0)
$p=Net::Ping->new("icmp", $timeout) or die "bye" ;
   
# Sets the value of $string to be the response to the ping request
$string = $p->ping($host);

# Creates a substring called $firstTwo from $string to take the first
# three characters from the response, which identifies if it's a
# response (1) or not (0)
$firstTwo = substr($string,0,1);

# Uses the localtime() funciton to get the current workstation date and time
# and puts it into the $datestring variable

# Depending on the value of $firstTwo it either prints "It's alive" to the console and
# nothing to the log file, or "It's dead jim" to both the console and the log file
# In both cases it precedes this with the date and time from $datestring

$datestring = localtime();
print "$datestring\n";
print "It's alive!\n\n" if ($firstTwo =~ m/(1)/);
# print "$datestring\n";
print "It's dead Jim!\n\n" if ($firstTwo =~ m/(0)/);
print RESULTS "$datestring\n" if ($firstTwo =~ m/(0)/);
print RESULTS "It's dead Jim!\n\n" if ($firstTwo =~ m/(0)/);



sleep(10);

$p->close;



}