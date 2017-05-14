OKI 9 & 24 PIN Linux CUPS Driver v2.0 - August 2010 
---------------------------------------------------

1.0 INTRODUCTION

This is OKI 9 & 24 Pin Linux driver.

2.0 REQUIREMENTS

2.1 OPERATING SYSTEM REQUIREMENTS

CUPS requirements are:

	- CUPS 1.2 or higher
	
3.0 INSTALLATION

	a) login as root
	   # su - root
	b) execute install.sh
	   # ./install.sh

4.0 DE-INSTALLATION

	a) login as root
	   # su - root
	b) execute install.sh
	   # ./uninstall.sh

5.0 CREATE QUEUE(S)

Below are steps to create queues:

	a) start a browser session and point to 'http://localhost:631'
	c) follow prompt to create queue
	d) select Make  - 'OKI'
	e) select Model - 'OKI 9 Pin Dot Matrix' or 'OKI 24 Pin Dot Matrix'
	f) follow remaining prompts until queue is created

6.0 FILE STRUCTURE

	+ readme.txt - instructions
	+ install.sh - installs driver
	+ uninstall.sh - uninstalls driver
	+ okdotmatrix9.ppd.gz - PPD
	+ okdotmatrix24.ppd.gz - PPD
	+ rastertookidotmatrix - CUPS filter

7.0 COPYRIGHT

Copyright (c) 2010 by Oki Data, America, Inc. All rights reserved.
