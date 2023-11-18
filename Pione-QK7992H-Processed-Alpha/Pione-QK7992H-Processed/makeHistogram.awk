BEGIN {
	for(i=0; i <=255; i++)
	{
		cnt[i] = 0
	}
}
{
	for(i=2; i <= NF; i++)
	{
		cnt[ $i ] += 1
	}
} 
END {
	for(i=0; i <=255; i++)
	{
		print "val " i " count " cnt[i]
	}
}