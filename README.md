## Course project "Getting and cleaning data" readme.

In this repository you will find three files:

* This file, README.md
* run_analysis.R - the R script created for the assignment
* CodeBook.md - the reference file where I list all the variables used in the
  script

 The script requires the plyr and reshape2 packages to work, and expects
 you to have the unzipped data, with it's subdirectories, in your working
 directory.

i.e. in your working directory you must have a subdirectory named:

"UCI HAR Dataset"

Wherever possible I have used plyr's join() command or cbind() to connect the
dataframes, because using merge() would have reordered them incorrectly.
