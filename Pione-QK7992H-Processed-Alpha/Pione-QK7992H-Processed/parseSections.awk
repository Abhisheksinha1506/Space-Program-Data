#input: qk7992h.raw.hex.plus.edcdic.asc
#output: section with same number of columns
#look at line headers blockNumber 5343 length 1536 
#
BEGIN { sectionCnt = 0 }
{
	if (FNR==1)
	{
		sz  = $4
		cnt = 1
		startLine = FNR-1
		fileNr = 1
	}
	else
	{
		if ($4 == sz)
		{
			cnt += 1
		}
		else
		{
			# start of a new section
			nLines = (FNR-2) - startLine + 1
			print "File #" fileNr " ,section #"sectionCnt " [ "  cnt " x " sz " ] from line(=blockNumber) " startLine " to " FNR-2 
			
			cnt = 1
			sz = $4
			sectionCnt += 1
			startLine = FNR-1
			
			if (sz == 360)
				fileNr += 1
		}
	}
}
END{
	nLines = (FNR-2) - startLine + 1
	print "File #" fileNr " ,section #"sectionCnt " [ "  cnt " x " sz " ] from line(=blockNumber) " startLine " to " FNR-2 
}