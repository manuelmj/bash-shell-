#! /bin/bash 

#this script organizes the files in different folders  according to their content,
#and also executes a new organization inside the main folders.

BLUE=$(tput setaf 6)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
CLEAR=$(tput sgr 0)


#This function checks for the existence of a directory. 
function check_directory(){ 
	if [ ! -d $1 ];
	then 
		mkdir $1 	
	fi 
}



cd $HOME
DIRECTORY=$(pwd)

if [ ! -d "/$DIRECTORY/Downloads" ];
then
	echo "$RED $(pwd)/Downloads :the directory does not exist... $CLEAR"
	echo " "
	while :
	do  
		echo " create the directory? (yes or no):"
		read -r option 

		if [ "$option" == "yes" ]; 
		then 
			cd $HOME
			mkdir Downloads
			break 
		elif [ "$option" == "no" ];
		then
			echo "$RED end of program... $CLEAN"
			exit 1 
		fi 
		echo " "
		echo "$RED enter a valid option $CLEAR"
		
	done 
fi



#cd "$DIRECTORY/Downloads"

OFFICE=".doc\$|.docx\$|.xlsx\$|.xls\$|.csv\$|.txt\$|.pptx\$|.odt\$"
COMPRESS=".zip\$|.rar\$|.tar\$|.deb\$|.arj\$|.bz2\$|.7z\$|.cab\$|.paq\$|.zipx\$|.xz\$|.gz\$"
IMAGES=".jpg\$|.jpeg\$|.png\$|.webp\$|.svg\$"
PDF="pdf\$"

echo -e "$GREEN init process ... $CLEAR"
echo -ne "$GREEN (0%) $CLEAR"
for files in ~/Downloads/*
do 

	
	if  file -i "$files" |tr ":" "\n" | head -n 1 | tr [:upper:] [:lower:] | egrep -q $PDF  && [ ! -d "$files" ];
	then 
			check_directory ~/Downloads/pdfs_files/
			mv "$files"  ~/Downloads/pdfs_files/
		elif  file -i "$files" | tr ":" "\n" | head -n 1 |tr [:upper:] [:lower:] | egrep -q ${COMPRESS} && [ ! -d "$files" ];
	then 
		check_directory ~/Downloads/zip_files/
		mv "$files" ~/Downloads/zip_files/
		
	elif  file -i "$files" | tr ":" "\n" |head -n 1 | tr [:upper:] [:lower:] | egrep -q $IMAGES  && [ ! -d "$files" ];
	then 
		check_directory ~/Downloads/images_files/
		mv "$files" ~/Downloads/images_files
	elif  file -i  "$files" | tr ":" "\n"|head -n 1 | tr [:upper:] [:lower:] | egrep -q ${OFFICE}  && [ ! -d "$files" ];
	then
		check_directory ~/Downloads/offices_files/
		mv "$files"  ~/Downloads/offices_files/	
	fi
		#coloca un espacio en color azul que indique la barra de progreso
 		echo -e "\033[44m\033[30m \033[0m\\c" 



done 
echo "$GREEN (100%) $CLEAR"
echo "$GREEN process completed  $CLEAR"




exit 0 

