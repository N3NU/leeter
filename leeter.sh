#! /usr/bin/bash

#Colors
R="\033[1;31m"
G="\033[0;32m" #GREEN
LG="\033[1;32m" #LIGHT GREEN
DG="\033[2;32m"	#DARK GREEN
NC="\033[0m"	#NO COLOR

#Display Banner
banner () {
echo 
echo -e       "    ${LG}_____        _______________________________________v0.1.0__Created_by_N3NU______"   
echo -e       "   /|    |      /|                                                                    \\ "  
echo -e       "  /#|    |     /#|     _______      ___________      ____      ___________      __     |" 
echo -e       " /@#|    |    /@#|    |#####@/|    |#########@/|    |##@/|    |#########@/|    |##|    |" 
echo -e       " |##|    |    |##|          |#|          |##@/#|    |#@/#|          |##@/#|            |" 
echo -e       " |##|    |    |##|     _____|#|     _____|  |##|    | |##|     _____|  |##|     _     /" 
echo -e       " |##|    |____|##|    |###@/##|    |####/_  |##|    | |##|    |####/_  |##|    |@\\    \\ " 
echo -e       " |##|                                     | |##|    | |##|           | |##|    |##|    |" 
echo -e       " |##|_____________________________________| |##|____| |##|___________| |##|____|##|____|" 
echo -e       " |@/####################################@/  |@/###@/  |@/##########@/  |@/###@/|@/###@/"  
echo -e       " |/@###################################@/   |/@##@/   |/@#########@/   |/@##@/ |/@##@/${NC} "
echo
}

banner

#checking input
if [ $# -lt 1 ]
then
	echo -e "${DG}[+]${NC} ${LG}Usage: ./leeter.sh <Word to Leet>${NC}"
    echo -e "${DG}[+]${NC} ${LG}Example: ./leeter.sh password${NC}"
    exit 1
elif [ $# -gt 1 ]
then
	echo -e "${DG}[+]${NC} ${LG}More than one argument detected${NC}"
	echo -e "${DG}[+]${NC} ${LG}Usage: ./leeter.sh <Word to Leet>${NC}"
    echo -e "${DG}[+]${NC} ${LG}Example: ./leeter.sh password${NC}"
else

	#declarations
	word=$1
	user_input_word_length=${#1}				#assigns the length of the input to variable
	iterations=$((($user_input_word_length + 5)/6))		#rounding up (input + (denom - 1)) / 6
	count_hold=0
	for partial_word in $(seq ${iterations})
	do
		user_input=${word:${count_hold}:6}
		user_input_word_length=${#user_input}				#assigns the length of the input to variable

		combinations=$((3**$user_input_word_length))		#not the true combination, just for use
		counter=1											#used to add user input characters to letter_hold
		declare -A letter_hold								#dictionary to map user input characters to numbers
		declare -A diction=( [character_position]=2 )		#used as place holder in code
		declare -A diction_two=( [character_position]=3 )	#used as place holder in code
		declare -A diction_four=( [character_position]=3 )	#used as place holder in code
		declare -A dict=( \
		[A]=4 [a]=4 [B]=8 [b]=8 [C]=c [c]=C [D]=d [d]=D [E]=3 [e]=3 [F]=f [f]=F [G]=9 [g]=9 \
		[H]=h [h]=H [I]=1 [i]=1 [J]=j [j]=J [K]=k [k]=K [L]=1 [l]=1 [M]=m [m]=M [N]=n [n]=N \
		[O]=0 [o]=0 [P]=p [p]=P [Q]=q [q]=Q [R]=2 [r]=2 [S]=5 [s]=5 [T]=7 [t]=7 [U]=u [u]=U \
		[V]=v [v]=V [W]=w [w]=W [X]=x [x]=X [Y]=y [y]=Y [Z]=2 [z]=2 [1]=l [2]=r [3]=e [4]=a \
		[5]=s [6]=6 [7]=t [8]=b [9]=g [0]=o ) 				#used to map alphabet to leet

		declare -a new_words=( "${user_input} " )			#used to hold new permutations of user input
		new_words+="${user_input^^} "						#used to uppercase user input and add to list

		#48cd3f9h1jk1mn0pq257uvwxy2

		###mapping the characters in user input string to numbers using the letter_hold dictionary 
		for chars in $(grep -o . <<< "$user_input")
		do
			letter_hold[${counter}]=${chars}
			((counter++))
		done

		###Creating new strings by substiting each character of each string in $new_words with leet
		for words in $(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		do
			count=1
			while [ $count -le ${user_input_word_length} ]
			do
				new_word=""
				chars_count=1
				for chars in $(grep -o . <<< "$words")
				do
					if [[ ${chars} == [a-zA-Z] ]] && [ $chars_count == $count ]
					then
						new_word=${new_word}${dict[${letter_hold[${chars_count}]}]}
					else
						new_word=${new_word}${chars}
					fi
					((chars_count++))
				done
				new_words+="$new_word "
				((count++))
			done
		done


		###Creating new strings by iterating through each character in user input and making uppercase
		count=1
		while [ $count -le ${user_input_word_length} ]
		do 
			new_word=""
			for num in $(seq ${user_input_word_length})
			do
				if [ $count -le ${user_input_word_length} ]
				then
				if [ ${num} -eq $count ] && [[ ${letter_hold[${num}]} == [a-zA-Z] ]]
					then 
						new_word=${new_word}${letter_hold[${num}]^^${letter_hold[${num}]}}
					else
						new_word=${new_word}${letter_hold[${num}]}
					fi
				fi
			done
			new_words+="$new_word "
			((count++))
		done


		###Creating new strings by groups of two characters then three then four...
		range_begin=1
		range_end=2
		if [ ${user_input_word_length} -gt 3 ]
		then
			count=1
			while [ $count -gt 0 ] && [ $count -lt $combinations ]
			do
				if [ ${range_end} -le ${user_input_word_length} ]
				then
					new_word=""
					for num in $(seq ${user_input_word_length})
					do
						if [ $num -ge $range_begin ] && [ $num -le $range_end ]
						then
							new_word=${new_word}${dict[${letter_hold[${num}]}]}
						else
							new_word=${new_word}${letter_hold[${num}]}
						fi
					done
					new_words+="$new_word "
				fi
				((count++))
				if [ $range_end != ${user_input_word_length} ]
				then
					((range_begin++))
					((range_end++))
				else
					range_end=$((${diction[character_position]}+1))
					range_begin=1
					diction[character_position]=$range_end
				fi
			done
		fi


		###Creating new strings by uppercasing characters 2 at a time then 3 then four 
		for words in $(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		do
			range_begin_three=1
			range_end_three=2
			holder=2
			while [ ${holder} -le ${user_input_word_length} ]
			do
				new_word=""
				k_count=1
				for k in $(grep -o . <<< "$words")
				do
					if [ $k_count -ge $range_begin_three ] && [ $k_count -le $range_end_three ] && [[ $k == [a-z] ]]
					then
						new_word=${new_word}${k^^$k}
					elif [ $k_count -ge $range_begin_three ] && [ $k_count -le $range_end_three ] && [[ $k == [0-9] ]]
					then
						new_word=${new_word}${letter_hold[${k_count}]^^}
					else
						new_word=${new_word}${k}
					fi
					((k_count++))
				done
				new_words+="$new_word "
			
				if [ $range_end_three != ${user_input_word_length} ]
				then
					((range_begin_three++))
					((range_end_three++))
				else
					range_end_three=$((${holder}+1))
					range_begin_three=1
					holder=$range_end_three
				fi
			done
		done


		###Creating new strings by changing two at a time ex. element 1 and 3 then element 1 and 4...*******************************************
		for words in $(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		do
			range_begin_two=1
			range_end_two=3
			holder=3
			while [ ${holder} -le ${user_input_word_length} ]
			do
				if [ ${range_end_two} -le ${user_input_word_length} ]
				then
					new_word=""
					k_count=1
					for k in $(grep -o . <<< "$words")
					do
						if [ $k_count -eq $range_begin_two ] || [ $k_count -eq $range_end_two ]
						then
							new_word=${new_word}${dict[${letter_hold[${k_count}]}]}
						else
							new_word=${new_word}${k}
						fi
						((k_count++))
					done
					new_words+="$new_word "
				fi
				if [ $range_end_two != ${user_input_word_length} ]
				then
					((range_end_two++))
				elif [ $range_begin_two != $((${user_input_word_length}-2)) ]
				then
					((range_begin_two++))
					range_end_two=$((${holder}+1))
					holder=$range_end_two
				else
					break
				fi
			done	
		done

		###Creating new strings by uppercasing two at a time ex. element 1 and 3 then element 1 and 4...
		for words in $(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		do
			range_begin_four=1
			range_end_four=3
			holder=3
			while [ ${holder} -le ${user_input_word_length} ]
			do
				if [ ${range_end_four} -le ${user_input_word_length} ]
				then
					new_word=""
					k_count=1
					for k in $(grep -o . <<< "$words")
					do
						if [ $k_count -eq $range_begin_four ] || [ $k_count -eq $range_end_four ] && [[ ${k} == [a-z] ]]
						then
							new_word=${new_word}${k^^${k}}
						else
							new_word=${new_word}${k}
						fi
						((k_count++))
					done
					new_words+="$new_word "
				fi
				((count++))
				if [ $range_end_four != ${user_input_word_length} ]
				then
					((range_end_four++))
				elif [ $range_begin_four != $((${user_input_word_length}-2)) ]
				then
					((range_begin_four++))
					range_end_four=$((${holder}+1))
					holder=$range_end_four
				else
					break
				fi
			done	
		done



		###Creating inverse strings of the strings in $new_words
		#new_words=$(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		#for i in ${new_words}
		for i in $(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		do
			new_word=""
			for k in $(grep -o . <<< $i)
			do
				if [[ $k == [a-zA-Z0-9] ]]
				then 
					new_word=${new_word}${dict[${k}]}
				else
					new_word=${new_word}${k}
				fi
			done
			new_words+=" $new_word "
		done


		###Creating new strings by uppercasing characters in the strings Ex. word --> WORD
		for words in $(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		do
			count=1
			while [ $count -le ${user_input_word_length} ]
			do
				new_word=""
				k_count=1
				for k in $(grep -o . <<< "$words")
				do
					if [[ ${k} == [a-zA-Z] ]] && [ $k_count == $count ]
					then
						new_word=${new_word}${k^^${k}}
					else
						new_word=${new_word}${k}
					fi
					((k_count++))
				done
				new_words+="$new_word "
				((count++))
			done
		done

		new_words=$(for i in ${new_words}; do echo ${i}; done | sort | uniq)
		for i in ${new_words}; do echo ${i}; done > ${partial_word}.txt
		((count_hold+=6))
	done


	if [ ${iterations} -gt 1 ]
	then
		count_hold=1
		for iter in $(seq 2 ${iterations})
		do
			for i in $(cat ${count_hold}.txt); do for k in $(cat $((count_hold+1)).txt); do echo ${i}${k};done;done > hold.txt
			mv hold.txt $((count_hold+1)).txt
			rm ${count_hold}.txt
			((count_hold++))
			if [ $count_hold -eq ${iterations} ]
			then
				mv ${count_hold}.txt ${1}.txt
			fi
		done
	elif [ ${iterations} -eq 1 ]
	then
		mv 1.txt ${1}.txt
		echo -e "${DG}[+]${NC} ${LG}Output file: ${1}.txt${NC}"
		echo -e "${DG}[+]${NC} ${LG}Permutations: $(wc -w ${1}.txt | awk -F " " '{print $1}')${NC}"
	fi
	#for i in $(cat jane.txt); do for k in $(cat street.txt); do echo ${i}${k};done;done > janestreet.txt




fi
##hold



