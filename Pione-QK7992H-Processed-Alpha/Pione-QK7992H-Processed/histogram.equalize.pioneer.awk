#
#
# take 1 one line of Red-blue-red-blue pixels
# we assume a label in column 1  i.e. $1
#
# use a -v nInputPlanes=1 
# for gray level
# or -v nInputPlanes=2
# if we have reb/blue input
#
BEGIN {
	imageDim = 768
	
	#imageDimSqr = imageDim * imageDim  # Gray scale
	#imageDimSqr = imageDim * imageDim * 2 #R/B images

	imageDimSqr = imageDim * imageDim * nInputPlanes
	
	nImages = 1
}
{
	if (NF == 1)
		print $0
	else
	{
		for (image=0; image < nImages; image++)
		{
			#init 
			for (i=0; i < 256; i++)
			{
				newcount[i]= 0
				count[i] = 0
				cdf  [i] = 0
			}
				
			#load data in counts
			for(pixelIdx=0; pixelIdx < (imageDimSqr); pixelIdx++)
			{
				# $2 is first valid pixel, Red is #0 and blue is the #1 channel i.e. add 'image'
				lineIdx = nImages * pixelIdx + 2 + image 
				count[ $(lineIdx) ] += 1
			}
			
			#print dbg org counts 
			if (0)
			{
				for(i=0; i< 256;i++)
				{
					print i " " count[i]
				}
			}
			
			#load data in cdf
			for(i=0; i < 256; i++)
			{
				cdf [i] = cdf[i-1] + count[i]
			}
			
			# find min index
			minIndex = -1
			for (cdfIdx=0; cdfIdx < 256; cdfIdx++)
			{
				if (cdf[cdfIdx] > 0)
				{
					if (minIndex == -1)
						minIndex = cdfIdx
				}
			}
			#print "minIndex =" minIndex
			
			# normalize image data 
			for(i=0; i < (imageDimSqr); i++)
			{
				#lineIdx = i           + 2 + (image*32*32)
				lineIdx  = nImages * i + 2 + image 
				
				value = $(lineIdx) 
				
				tmp = ((cdf[value] * 1.0 - 1)/ (imageDimSqr)) * 255.0
				newValue = int(tmp + 0.5)
				if (newValue > 255)
					newValue = 255
					
				#write it out 
				$(lineIdx) = newValue
				
				#if (value > 0)
				#	print "i= " i " lineIdx= " lineIdx " orgvalue=" value " tmp= " tmp " new value=" newValue
			}
			
			if (0)
			{
				#DBG print cdf AFTER correction
				for(i=0; i< 256;i++)
				{
					print i " " cdf[i]
				}
				for(pixelIdx=0; pixelIdx < (imageDimSqr); pixelIdx++)
				{
					# $2 is first valid pixel, Red is #0 and blue is the #1 channel i.e. add 'image'
					lineIdx = nImages * pixelIdx + 2 + image 
					newcount[ $(lineIdx ) ] += 1
				}
				for(i=0; i< 256;i++)
				{
					print i " " newcount[i]
				}
			}
		} # end for all images (3)
		
		# Print image
		print $0
		
	} # end else
}