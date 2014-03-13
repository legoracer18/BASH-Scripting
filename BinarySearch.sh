#!/bin/bash

# This program will read in names and grades from a file (i.e. text file) that
# are in the following format "name:grade" while grade is just the letter grade.
# The file that I will be reading from is "grades.txt". This program is built to 
# keep prompting the user for input until the users inputs 'q' to quit.

# Read the file into an array
students=( `cat "grades.txt"` )
# This is just a flag that will quit the program if the user inputs 'q' at the prompt.
quit=0

while [[ $quit == 0 ]] ; do
   length=${#students[@]}
   lowIndex=0
   highIndex=$((length - 1))
   # flag to signify that the name inputed was found.
   found=0
   # read input from user with a prompt
   read -p "What name do you want to search for? (q to quit)" input
   
   if [[ $input != q ]] ; then
      while [[ $lowIndex -le $highIndex ]] ; do
         midPoint=$(((lowIndex + highIndex) / 2))
         # Get the string that is now in the middle of the search from the array.
         itemInMiddle=${students[$midPoint]}
         # split up the array at the ':' character with the first part being the name
         # and the second part being the grade
         name=`echo $itemInMiddle | cut -d: -f1`
         grade=`echo $itemInMiddle | cut -d: -f2`
         if [[ $name == $input ]] ; then
            # Yay! The name was found.
            echo $input "has the following grade:" $grade
            # Do the following to break out of the while loop
            ((lowIndex=$lowIndex + $length))
            flag=1
         elif [[ $name < $input ]] ; then
            ((lowIndex=$midPoint + 1))
         elif [[ $name > $input ]] ; then
            ((highIndex=$midPoint - 1))
         fi
      done
      
      # Test to see if the name was not found
      if [[ $flag == 0 ]] ; then
         echo $input "is not registered for the class."
      fi
   else
      ((quit=1))
   fi
done
