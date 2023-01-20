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


	if [ ! -d "$files" ];
	then 
		filter_file=$(file -i "$files" |tr ":" "\n" | head -n 1 | tr [:upper:] [:lower:])

		if echo "$filter_file" | egrep -q ${PDF};
		then 
			check_directory ~/Downloads/pdfs_files/
			mv "$files"  ~/Downloads/pdfs_files/

		elif echo "$filter_file" | egrep -q ${COMPRESS};
		then 
			check_directory ~/Downloads/zip_files/
			mv "$files" ~/Downloads/zip_files/
		
		elif echo "$filter_file" | egrep -q ${IMAGES};
		then 
			check_directory ~/Downloads/images_files/
			mv "$files" ~/Downloads/images_files

		elif echo "$filter_file" | egrep -q ${OFFICE};
		then
			check_directory ~/Downloads/offices_files/
			mv "$files"  ~/Downloads/offices_files/ 
		fi

	fi 

		#coloca un espacio en color azul que indique la barra de progreso
 		echo -e "\033[44m\033[30m \033[0m\\c" 

done 
echo "$GREEN (100%) $CLEAR"
echo "$GREEN process completed  $CLEAR"



while : 
do 

	echo  "$GREEN desea organizar los archivos de las carpetas principales? (yes or no): $CLEAR"
	read -r option

	if [ "$option" == "yes" ];
	then 

		echo -e "$GREEN init internal process in office files ... $CLEAR"
		echo -ne "$GREEN (0%) $CLEAR"
		for files in ~/Downloads/offices_files/*
		do

			if [ ! -d "$files" ];
			then 
				filter_internal_file=$(file -i "$files" |tr ":" "\n" | head -n 1 | tr [:upper:] [:lower:])
				if echo "$filter_internal_file" | egrep -q ".doc\$|.docx\$|.odt\$";
				then 
					check_directory ~/Downloads/offices_files/word_files/
					mv "$files"  ~/Downloads/offices_files/word_files/

				elif echo "$filter_internal_file" | egrep -q ".xlsx\$|.xls\$|.csv\$";
				then 
					check_directory ~/Downloads/offices_files/excel_files/
					mv "$files" ~/Downloads/offices_files/excel_files/

				elif echo "$filter_internal_file" | egrep -q ".pptx\$";
				then 
					check_directory ~/Downloads/offices_files/powerpoint_files/
					mv "$files" ~/Downloads/offices_files/powerpoint_files

				elif echo "$filter_internal_file" | egrep -q ".txt\$";
				then
					check_directory ~/Downloads/offices_files/text_files/
					mv "$files"  ~/Downloads/offices_files/text_files/ 

				fi	
			fi
			echo -e "\033[45m\033[30m \033[0m\\c" 
		done
		echo "$GREEN (100%) $CLEAR"

		echo " "

		echo -e "$GREEN init internal process in images files ... $CLEAR"
		echo -ne "$GREEN (0%) $CLEAR"
		for files in ~/Downloads/images_files/*
		do 
			if [ ! -d "$files" ];
			then 
				filter_internal_file=$(file -i "$files" |tr ":" "\n" | head -n 1 | tr [:upper:] [:lower:])
				
				if echo "$filter_internal_file" | egrep -q ".jpg\$|.jpeg\$";
				then 
					check_directory ~/Downloads/images_files/jpg_files/
					mv "$files"  ~/Downloads/images_files/jpg_files/

				elif echo "$filter_internal_file" | egrep -q ".png\$";
				then 
					check_directory ~/Downloads/images_files/png_files/
					mv "$files" ~/Downloads/images_files/png_files/

				elif echo "$filter_internal_file" | egrep -q ".webp\$";
				then 
					check_directory ~/Downloads/images_files/webp_files/
					mv "$files" ~/Downloads/images_files/webp_files

				elif echo "$filter_internal_file" | egrep -q ".svg\$";
				then
					check_directory ~/Downloads/images_files/svg_files/
					mv "$files"  ~/Downloads/images_files/svg_files/ 

				fi	
			fi
			echo -e "\033[46m\033[30m \033[0m\\c" 
		done 
		echo -ne "$GREEN (100%) $CLEAR"
		break 
	
	elif [ "$option" == "no" ];
	then
		echo "$GREEN end of program... $CLEAR"
		exit 0
	fi

	echo " "
	echo "$RED---enter a valid option---$CLEAR"


done 

echo " "
exit 0 

