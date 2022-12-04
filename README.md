# PingMonitor
 Perl script to ping devices and log downtime

 This script comes from a requirement to detect devices on my network which drop periodically. Sending a continuous ping and writing to a log file results in a very long text file through which you have to scroll to find any 'no response'.

 This script pings at intervals and while both positive and negative results are displayed on the console, only negative results are logged to the file.

 The script has a lot of comments, which will hopefully explain what is happening.
