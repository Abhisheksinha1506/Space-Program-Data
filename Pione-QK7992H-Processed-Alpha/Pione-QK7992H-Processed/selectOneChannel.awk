#
#
#-v channel=0 
#or
#-v channel=1 
#
{
	str=""
	for(i=1; i<= NF; i++)
	{
		if (i >=8)
		{
			#print "field:" $i
		
			if ((i %2)==channel)
				str = str " " $i
		}
		else
		{
			if (length(str)==0)
				str = $i
			else
				str = str " " $i
		}
	}
	print str
}