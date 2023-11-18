BEGIN {
	str = "1"
}
{
	# ignore first 7 argument and print 768 others
	for(i=8; i<=NF; i++)
	{
		hexvalue = $i
		decvalue = sprintf("%d","0x" hexvalue);
		
		#if (hexvalue != "00")
		#	print hexvalue " " decvalue
		
		str = str " " decvalue
	}
}
END { 
	print str
}