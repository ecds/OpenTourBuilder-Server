#! /usr/bin/python

import os

nums = range(1,100)

for num in nums:
	os.system('wget http://mibazaar.com/education/images/marker' + str(num) + '.png')
