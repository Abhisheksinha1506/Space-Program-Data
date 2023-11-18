Curated/processed by Hans, aka leovinus.
A webforum topic about this project, with the most recent data, can be found at the link below"
https://forum.nasaspaceflight.com/index.php?topic=46255.40


INFORMATION KNOWN AS OF 09/20/2018 BELOW, Rev A.

Summary Rev A:

This directory 'Pione-QK7992H-Processed.dir' has 12 files, each with a description based on text from the tape, plus data.
For some files it is clear those are images.
Other files, like file4/ , it is clear there is some info (see picture in there) but not what it represents.

The ".dat" files are formatted ASCII data files, as opposed to ".txt" generic, unformatted ASCII files. They were used to make the PNG images.

"awk" is a scripting language to quickly reformat ASCII text and tables.

List of files in "filelist.txt".

- Three images on this tape qk7992h:

	ZELLNER/MAY 21,1978  
	IMG 1530 , exposure time 12MIN,16:35Z, 	file 1  - 5
	IMG 1531 , exposure time 50MIN 17:30Z, 	file 5  - 10
	IMG 1532 , exposure time  5MIN 18:39Z, 	file 11 - 12

- Using: CCAM 2 IMAGE 1530        PROC VERSN 211 PARAM SET NO 8 

- We get 5 parts/files on the tape for each image it seems:
	- IMG 1530, file #1 to #5
	File #1: ******************  RAW IMAGE  *****************      768 x 768
	File #2: *********  GEOM. & PHOTOM. CORRECTED IMAGE  ********* 768 x 1536         	
	File #3: ********  DATA FROM SMALL APERTURE  ********           55 x 818
	File #4: ***** LINE-BY-LINE SPECTRUM, SPATIALLY RESOLVED ***** 166 x 1024                
	File #5 *****  FILE OF MERGED EXTRACTED SPECTRA  *****           7 x 1024
	        *****  GROSS, BACKGROUND, NET, & ABSOL. CALIB. NET  *****              
	- IMG 1531, file #6 to #9, follow the same scheme
	- IMG 1532, file #10 and #11 are similar to file #1 and #2

- Every filexx/ directory/ has a description, the [ N x 360 ] text lines from the tape.

Details:

1) Compare to the original qk7992h.log, but with this script we see 24 blocks in 12 sections.
   We assume that each section has a pair of [ N x 360 ] followed by [M x K] data together.

awk -f parseSections.awk qk7992h.raw.hex.plus.edcdic.asc

File #1 ,section #0 [ 21  x 360 ] from line(=blockNumber) 0 to 20		#IMG 1530
File #1 ,section #1 [ 768 x 768 ] from line(=blockNumber) 21 to 788	

File #2 ,section #2 [ 23  x 360  ] from line(=blockNumber) 789 to 811 
File #2 ,section #3 [ 768 x 1536 ] from line(=blockNumber) 812 to 1579 	

File #3 ,section #4 [ 24 x 360 ] from line(=blockNumber) 1580 to 1603
File #3 ,section #5 [ 55 x 818 ] from line(=blockNumber) 1604 to 1658

File #4 ,section #6 [ 25  x 360 ]  from line(=blockNumber) 1659 to 1683
File #4 ,section #7 [ 166 x 1204 ] from line(=blockNumber) 1684 to 1849

File #5 ,section #8 [ 25 x 360  ] from line(=blockNumber) 1850 to 1874
File #5 ,section #9 [  7 x 1204 ] from line(=blockNumber) 1875 to 1881

File #6 ,section #10 [ 21  x 360 ] from line(=blockNumber) 1882 to 1902		#IMG 1531
File #6 ,section #11 [ 768 x 768 ] from line(=blockNumber) 1903 to 2670 

File #7 ,section #12 [ 23  x 360  ] from line(=blockNumber) 2671 to 2693  
File #7 ,section #13 [ 768 x 1536 ] from line(=blockNumber) 2694 to 3461	

File #8 ,section #14 [ 24 x 360 ] from line(=blockNumber) 3462 to 3485
File #8 ,section #15 [ 55 x 818 ] from line(=blockNumber) 3486 to 3540

File #9 ,section #16 [  25 x 360  ] from line(=blockNumber) 3541 to 3565
File #9 ,section #17 [ 166 x 1204 ] from line(=blockNumber) 3566 to 3731

File #10 ,section #18 [ 25 x 360  ] from line(=blockNumber) 3732 to 3756
File #10 ,section #19 [  7 x 1204 ] from line(=blockNumber) 3757 to 3763

File #11 ,section #20 [  21 x 360 ] from line(=blockNumber) 3764 to 3784		#IMG 1532
File #11 ,section #21 [ 768 x 768 ] from line(=blockNumber) 3785 to 4552    

File #12 ,section #22 [  23 x 360  ] from line(=blockNumber) 4553 to 4575
File #12 ,section #23 [ 768 x 1536 ] from line(=blockNumber) 4576 to 5343

Questions
- File #1 and #2 form images of sorts but what are #3/#4/#5 ? Not images it seems. 
  The  descriptions help but it is not clear how to apply that on File #1 or #2 for a better image.

The IPP buffer was 6144 bits [1]. That happens to be 768 bytes i.e. a full scan.
[1] https://history.nasa.gov/SP-349/app1.htm

Mhh, 6144 / 6 is 1024 potential 6 bit pixels if we pack it.

2) Details & analysis

We make directories for each section or file number [1..12]

file1/ ================================================================

We used this command to get the pretty ASCII description
head -21 qk7992h.all.ascii.asc  | awk -f splitin72char.awk > qk7992h.dir/file1/file1.description.from.section0.txt

	a) We see 100 lines of FORTRAN comments 'C' and a description of the image of 768 x 768 to follow

	 ******************  RAW IMAGE  *****************                       
	C*SAR   16:35Z MAY 31,'78                                              H
	L                                                                       

	b) The first line of presumed FORTRAN in file1.description.from.section0.txt is:
	                         0001000107680768   1 2 2020 1530            1  
	and the numbers 07680768 match the dimension of the block to follow 768 x 768 pixels.

	Question: Does 00010001 has a meaning as well. like "1 of 1" ? 

	c) the 1530 is the image number of the tape, see line 4 
	CCAM 2 IMAGE 1530        PROC VERSN 211 PARAM SET NO 8               4  

	d) Question:
	if this was between Jupiter and Saturn, then why the 'Vesta' (planetoid?) reference?
	CLWR1530   VESTA,12MIN,SM.AP.,LO-DISP  ZELLNER/MAY 21,1978           3  

Image data
- file1.image.asc.txt    The lines 21 to 788 with an image 768 x 768
- awk '{ $1=$2=$3=$4=$5=$6=$7=""; print $0}' file1/file1.image.asc.txt | sed 's/        00/00/'  > file1/file1.image.asc.noblocknumber.txt
- file1.image.asc.noblocknumber.txt  The lines 21 to 788 with an image 768 x 768. no "blocknumber xx" header
- Dump all image data in 1 line to make PNG picture
	awk -f convert.awk file1/file1.image.asc.txt  > file1/file1.dat & 
- Make an contrast equalized version
	awk -v nInputPlanes=1 -f histogram.equalize.pioneer.awk file1/file1.dat > file1/file1.equalized.dat

file2/ ================================================================

head -812 qk7992h.all.ascii.asc | tail -23| awk -f splitin72char.awk > qk7992h.dir/file2/file2.description.from.section2.txt

To highlight the difference between 768 x 768 image vs 768 x 1536 image:

diff file1/file1.description.from.section0.txt file2/file2.description.from.section2.txt 
1c1
<                          0001000107680768   1 2 2020 1530            1  
---
>                          0001000107681536   1 2 2020 1530            1  
106,107c106,116
<  ******************  RAW IMAGE  *****************                       
< C*SAR   16:35Z MAY 31,'78                                              H
---
>  *GEOMF   16:35Z MAY 31,'78                                            H
> C*********  GEOM. & PHOTOM. CORRECTED IMAGE  *********                  
> CPCF C/** DATA REC. 12 1   1   1 768 9216 5 2  6.1  5.0 2536   .00000 1P
> C          0       2303       4069       8008      10073      11878   1P
> C      15883      20149      24471      29391      34333      42032   1P
>       17.000     17.000     17.000     17.000     17.000     17.000   1P
> C     17.000     17.000     17.000     17.000     17.000     17.000   1P
> CTUBE   2 SEC EHT  6.1 ITT EHT  5.0 WAVELENGTH 2536 DIFFUSER 0        1P
> C     C     MODE : FACTOR   .283E 00                                  1P
> C*FICOR   16:35Z MAY 31,'78                                            H
>  *SAR   16:35Z MAY 31,'78                                              H
110a120

# get the image data including the blocknumber headers
awk '{ if (($2 >= 812) &&( $2 <=1579)) print $0}' qk7992h.raw.hex.plus.edcdic.asc > file2/file2.img.768x1536.asc.txt
awk '{ $1=$2=$3=$4=$5=$6=$7=""; print $0}' file2/file2.img.768x1536.asc.txt > file2/file2.image.768x1536.asc.noblocknumber.txt
awk -v channel=0 -f selectOneChannel.awk file2/file2.img.768x1536.asc.txt > file2/file2.img.768x1536.asc.red.txt
awk -v channel=1 -f selectOneChannel.awk file2/file2.img.768x1536.asc.txt > file2/file2.img.768x1536.asc.blue.txt

#convert to input for PNG tool
awk -f convert.awk file2/file2.img.768x1536.asc.red.txt  > file2/file2.red.dat & 
awk -f convert.awk file2/file2.img.768x1536.asc.blue.txt > file2/file2.blue.dat & 
awk -f convert.awk file2/file2.img.768x1536.asc.txt      > file2/file2.red.blue.dat & 

#make contrast equalized versions
awk -v nInputPlanes=1 -f histogram.equalize.pioneer.awk file2/file2.red.dat > file2/file2.red.equalized.dat
awk -v nInputPlanes=1 -f histogram.equalize.pioneer.awk file2/file2.blue.dat > file2/file2.blue.equalized.dat
awk -v nInputPlanes=2 -f histogram.equalize.pioneer.awk file2/file2.red.blue.dat > file2/file2.red.blue.equalized.dat

file3/ ================================================================

head -1604 qk7992h.all.ascii.asc | tail -24| awk -f splitin72char.awk > qk7992h.dir/file3/file3.description.from.section4.txt

	The block has 818 columns. Looks like 
	
	blockNumber 1604 length 818 error  0 :: 00 00 00 4e 00 6c 00 ..
	blockNumber 1605 length 818 error  0 :: 00 00 00 af 00 94 00 ..
	blockNumber 1606 length 818 error  0 :: 00 56 00 3a 00 00 00 ..
	
	i.e. there is no counter in column 0 and 1, no discernable pattern.

	Description says:
		File #3: ********  DATA FROM SMALL APERTURE  ********           55 x 818

	818 == 2*409 and in File#4, with length 1206, that has a counter + length marker in it to say (01 99) which if that is hex 409, then in decimal 409. Coincidence no I think.

file4/ ================================================================

head -1684 qk7992h.all.ascii.asc | tail -25| awk -f splitin72char.awk > qk7992h.dir/file4/file4.description.from.section6.txt

Visualized as  file4.slice.png. There is structure but what is it?

	blockNumber 1685 length 1204 error  0 :: 00 01 01 99 20 25 20 39
	blockNumber 1686 length 1204 error  0 :: 00 02 01 99 00 5c 00 5b 00 5b
	blockNumber 1687 length 1204 error  0 :: 00 03 01 99 ff f3 00 55 00 76 

	blockNumber 1688 length 1204 error  0 :: 00 04 01 99 20 25 20 39 20 4d 
	blockNumber 1689 length 1204 error  0 :: 00 05 01 99 00 5c 00 5c 00 5b
	blockNumber 1690 length 1204 error  0 :: 00 06 01 99 ff a5 00 be 00 a1 
	etc

	a) we see as data a counter (2 bytes) and a length (01 99) which seems to be 0x199 == 409 columns or measurements
	b) we see a pattern of sets of 3 blocks repeating. The first of set has the "20 25 20 39", the triangular pattern.

file5/ ================================================================
head -1875 qk7992h.all.ascii.asc | tail -25| awk -f splitin72char.awk > qk7992h.dir/file5/file5.description.from.section8.txt

file6/ ================================================================
head -1903 qk7992h.all.ascii.asc | tail -21| awk -f splitin72char.awk > qk7992h.dir/file6/file6.description.from.section10.txt

(Longer exposure and different mode?)

diff file1/file1.description.from.section0.txt  file6/file6.description.from.section10.txt 
1,5c1,5
<                          0001000107680768   1 2 2020 1530            1  
< C      *      *      *   *   *   720*      *   *  * * * * * *     *  2  
< CLWR1530   VESTA,12MIN,SM.AP.,LO-DISP  ZELLNER/MAY 21,1978           3  
< CCAM 2 IMAGE 1530        PROC VERSN 211 PARAM SET NO 8               4  
< C       NO LAMP-EXP TIME=719 SECS                                    5  
---
>                          0001000107680768   1 1 0020 1531            1  
> C      *      *      *   *   *  2999*      *   *  * * * * * *     *  2  
> CLWR1531  VESTA,50MIN,SM.AP.,LO-DISP  ZELLNER/MAY 21,1978            3  
> CCAM 2 IMAGE 1531        PROC VERSN 211 PARAM SET NO 8               4  
> C       NO LAMP-EXP TIME=2999 SECS                                   5  
15,19c15,19
< C                                *083656 SPREP 2                  * 15  
<  092642 EXPOBCM 2 12 0  MAXG NOL *                                * 16  
< C093851 EXPOSURE END TIME        *                                * 17  
< C                                *                                * 18  
< C094531   READ 2 LO SS 1 NORMAL  *                                * 19  
---
> C095730                          *101929 SPREP 2                  * 15  
>  110900 EXPOBCM 2 30 0  MAXG NOL *105542 MODTIME 2 20 0           * 16  
> C113858 EXPOSURE END TIME        *095733                          * 17  
> C095734                          *095734                          * 18  
> C114731   READ 2 LO SS 1 NORMAL  *095735                          * 19  
26c26
<  094052 MODE LWH                 *                                * 26  
---
>  102015 MODE LWL                 *                                * 26  


file7/ ================================================================
head -2694 qk7992h.all.ascii.asc | tail -23| awk -f splitin72char.awk > qk7992h.dir/file7/file7.description.from.section12.txt


diff file6/file6.description.from.section10.txt  file7/file7.description.from.section12.txt
1c1
<                          0001000107680768   1 1 0020 1531            1  
---
>                          0001000107681536   1 1 0020 1531            1  
106,111c106,120
<  ******************  RAW IMAGE  *****************                       
< C*SAR   17:30Z MAY 31,'78                                              H
< L  | "              } } | } } } }   } }   } }     c } } } }  e7  e7 } | 
< | U +   } + +     ' h   }     h   '               } / /     c  e7 ]   } 
<     } }     d   / ]       U     ]   } }   ] } /   ] /   < ] n } ]  e4   
< '   }    
---
>  *GEOMF   17:30Z MAY 31,'78                                            H
> C*********  GEOM. & PHOTOM. CORRECTED IMAGE  *********                  
> CPCF C/** DATA REC. 12 1   1   1 768 9216 5 2  6.1  5.0 2536   .00000 1P
> C          0       2303       4069       8008      10073      11878   1P
> C      15883      20149      24471      29391      34333      42032   1P
>       17.000     17.000     17.000     17.000     17.000     17.000   1P
> C     17.000     17.000     17.000     17.000     17.000     17.000   1P
> CTUBE   2 SEC EHT  6.1 ITT EHT  5.0 WAVELENGTH 2536 DIFFUSER 0        1P
> C     C     MODE : FACTOR   .283E 00                                  1P
> C*FICOR   17:30Z MAY 31,'78                                            H
>  *SAR   17:30Z MAY 31,'78                                              H
> L                                                                       
>                                                                         
>                                                                       

file8/ ================================================================
head -3486 qk7992h.all.ascii.asc | tail -24| awk -f splitin72char.awk > qk7992h.dir/file8/file8.description.from.section14.txt

file9/ ================================================================
head -3566 qk7992h.all.ascii.asc | tail -25| awk -f splitin72char.awk > qk7992h.dir/file9/file9.description.from.section16.txt

file10/ ================================================================
head -3757 qk7992h.all.ascii.asc | tail -25| awk -f splitin72char.awk > qk7992h.dir/file10/file10.description.from.section18.txt

file11/ ================================================================
head -3785 qk7992h.all.ascii.asc | tail -21| awk -f splitin72char.awk > qk7992h.dir/file11/file11.description.from.section20.txt

diff file1/file1.description.from.section0.txt  file11/file11.description.from.section20.txt 
1,5c1,5
<                          0001000107680768   1 2 2020 1530            1  
< C      *      *      *   *   *   720*      *   *  * * * * * *     *  2  
< CLWR1530   VESTA,12MIN,SM.AP.,LO-DISP  ZELLNER/MAY 21,1978           3  
< CCAM 2 IMAGE 1530        PROC VERSN 211 PARAM SET NO 8               4  
< C       NO LAMP-EXP TIME=719 SECS                                    5  
---
>                          0001000107680768   1 2 2020 1532            1  
> C      *      *      *   *   *   300*      *   *  * * * * * *     *  2  
> CLWR1532   VESTA,5MIN,SM.AP.,LO-DISP  ZELLNER/MAY 21,1978            3  
> CCAM 2 IMAGE 1532        PROC VERSN 211 PARAM SET NO 8               4  
> C                                                                    5  
10c10
< C78141074329*     *    **8   * 21*074330 CAMINIT                  * 10  
---
> C           *     *     *        *                                * 10  
15,17c15,17
< C                                *083656 SPREP 2                  * 15  
<  092642 EXPOBCM 2 12 0  MAXG NOL *                                * 16  
< C093851 EXPOSURE END TIME        *                                * 17  
---
> C                                *                                * 15  
>                                  *                                * 16  
> C                                *                                * 17  
19c19
< C094531   READ 2 LO SS 1 NORMAL  *                                * 19  
---
> C133914   READ 2 LO SS 1 NORMAL  *                                * 19  
26c26
<  094052 MODE LWH                 *                                * 26  
---
>                               

> C*SAR   18:39Z MAY 31,'78                                              H
> L  e6    Q a5  Q e4   90  ILLEGAL FORMAT SYNTAX.  FORMAT PAREN NESTING T
> OO DEEP.  NO FORMAT SPEC FOR REMAINING DATA.  G22.15 FORMAT USED. SUPERF
> LUOUS NUMBER IN FORMAT IGNORED.   NEGATIVE COUNT IN FORMAT.   MISSING OR
>  NEGATIVE

file12/ ================================================================
head -4576 qk7992h.all.ascii.asc | tail -23| awk -f splitin72char.awk > qk7992h.dir/file12/file12.description.from.section22.txt

diff file11/file11.description.from.section20.txt file12/file12.description.from.section22.txt 
1c1
<                          0001000107680768   1 2 2020 1532            1  
---
>                          0001000107681536   1 2 2020 1532            1  
102,107c102,116
<  ******************  RAW IMAGE  *****************                       
< C*SAR   18:39Z MAY 31,'78                                              H
< L  e6    Q a5  Q e4   90  ILLEGAL FORMAT SYNTAX.  FORMAT PAREN NESTING T
< OO DEEP.  NO FORMAT SPEC FOR REMAINING DATA.  G22.15 FORMAT USED. SUPERF
< LUOUS NUMBER IN FORMAT IGNORED.   NEGATIVE COUNT IN FORMAT.   MISSING OR
<  NEGATIVE
---
>  *GEOMF   18:39Z MAY 31,'78                                            H
> C*********  GEOM. & PHOTOM. CORRECTED IMAGE  *********                  
> CPCF C/** DATA REC. 12 1   1   1 768 9216 5 2  6.1  5.0 2536   .00000 1P
> C          0       2303       4069       8008      10073      11878   1P
> C      15883      20149      24471      29391      34333      42032   1P
>       17.000     17.000     17.000     17.000     17.000     17.000   1P
> C     17.000     17.000     17.000     17.000     17.000     17.000   1P
> CTUBE   2 SEC EHT  6.1 ITT EHT  5.0 WAVELENGTH 2536 DIFFUSER 0        1P
> C     C     MODE : FACTOR   .283E 00                                  1P
> C*FICOR   18:39Z MAY 31,'78                                            H
>  *SAR   18:39Z MAY 31,'78                                              H
> L                                                                       
>                       

3) Looking at the difference in description of file #1 to #5, IMG 1530

Note that the dimensions, like 768 x 768 show up in line #1.

diff file1/file1.description.from.section0.txt  file2/file2.description.from.section2.txt 
1c1
<                          0001000107680768   1 2 2020 1530            1  
---
>                          0001000107681536   1 2 2020 1530            1  
106,107c106,116
<  ******************  RAW IMAGE  *****************                       
< C*SAR   16:35Z MAY 31,'78                                              H
---
>  *GEOMF   16:35Z MAY 31,'78                                            H
> C*********  GEOM. & PHOTOM. CORRECTED IMAGE  *********                  
> CPCF C/** DATA REC. 12 1   1   1 768 9216 5 2  6.1  5.0 2536   .00000 1P
> C          0       2303       4069       8008      10073      11878   1P
> C      15883      20149      24471      29391      34333      42032   1P
>       17.000     17.000     17.000     17.000     17.000     17.000   1P
> C     17.000     17.000     17.000     17.000     17.000     17.000   1P
> CTUBE   2 SEC EHT  6.1 ITT EHT  5.0 WAVELENGTH 2536 DIFFUSER 0        1P
> C     C     MODE : FACTOR   .283E 00                                  1P
> C*FICOR   16:35Z MAY 31,'78                                            H
>  *SAR   16:35Z MAY 31,'78                                              H
110a120
>                                                                         


diff file2/file2.description.from.section2.txt  file3/file3.description.from.section4.txt 
1c1
<                          0001000107681536   1 2 2020 1530            1  
---
>                          0001000100550818   1 2 2020 1530            1  
116c116,123
<  *SAR   16:35Z MAY 31,'78                                              H
---
>  ********  DATA FROM SMALL APERTURE  ********                           
> C********  DATA FROM SMALL APERTURE  ********                           
> C*EXTLOW   17:06Z MAY 31,'78                                           H
> C@EXTLOW :HT= 9, DC#=   1; ISN:     0 PSN      1 SIGS=  .307 SIGL=  .265
> CB 1= -.266830844221D 03 B 2=  .225982053009D 00 B 3=  .000000000000D 00
>  A 1= -.298879489603D 03 A 2=  .302397432558D 00 A 3=  .000000000000D 00
> C                                                                       
> C*SAR   17:06Z MAY 31,'78                                              H
119,120d125
<                                                                         
<  
                                                                       
diff file3/file3.description.from.section4.txt  file4/file4.description.from.section6.txt 
1c1
<                          0001000100550818   1 2 2020 1530            1  
---
>                          0001000101661204   1 2 2020 1530            1  
122a123,126
> C*CORWAV2   17:06Z MAY 31,'78                                          H
> C*ITOE   17:06Z MAY 31,'78                                             H
> C***** LINE-BY-LINE SPECTRUM, SPATIALLY RESOLVED *****                  
>  *ETOEM   17:06Z MAY 31,'78                                            H
125a130
>  
                                                                       
diff file4/file4.description.from.section6.txt  file5/file5.description.from.section8.txt 
1c1
<                          0001000101661204   1 2 2020 1530            1  
---
>                          0001000100071204   1 2 2020 1530            1  
122a123
> C*SMOOTH2   17:06Z MAY 31,'78                                          H
125,126c126,128
< C***** LINE-BY-LINE SPECTRUM, SPATIALLY RESOLVED *****                  
<  *ETOEM   17:06Z MAY 31,'78                                            H
---
>  *****  FILE OF MERGED EXTRACTED SPECTRA  *****                         
> C*****  GROSS, BACKGROUND, NET, & ABSOL. CALIB. NET  *****              
> C*ETOEM   17:06Z MAY 31,'78                                            H
129,130d130
<                                                                         
<                                                                        
