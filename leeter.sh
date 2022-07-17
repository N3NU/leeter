#! /usr/bin/bash

#modules


#variables
read -p "Please enter word to leet: " user_input
user_input_word_length=${#user_input}
combinations=$((2**$user_input_word_length))
counter=1
declare -A letter_hold
declare -A diction=( [character_position]=2 )
declare -A diction_two=( [character_position]=3 )
declare -A dict=( \
[A]=4 [a]=4 [B]=8 [b]=8 [C]=c [c]=C [D]=d [d]=D [E]=3 [e]=3 [F]=f [f]=F [G]=9 [g]=9 \
[H]=h [h]=H [I]=1 [i]=1 [J]=j [j]=J [K]=k [k]=K [L]=1 [l]=1 [M]=m [m]=M [N]=n [n]=N \
[O]=0 [o]=0 [P]=p [p]=P [Q]=q [q]=Q [R]=2 [r]=2 [S]=5 [s]=5 [T]=7 [t]=7 [U]=u [u]=U \
[V]=v [v]=V [W]=w [w]=W [X]=x [x]=X [Y]=y [y]=Y [Z]=2 [z]=2 [1]=l [2]=r [3]=e [4]=a \
[5]=s [6]=6 [7]=t [8]=b [9]=g [0]=o ) 

declare -a new_words=( "${user_input} " )


#48cd3f9h1jk1mn0pq257uvwxy2
#user prompt


#code
for i in $(grep -o . <<< "$user_input")
do
	letter_hold[${counter}]=${i}
	((counter++))
done
count=1

while [ $count -le ${user_input_word_length} ]
do 
	new_word=""
	for i in $(seq ${user_input_word_length})
	do
		if [ $count -le ${user_input_word_length} ]
		then
			if [ $i -eq $count ]
			then 
				new_word=${new_word}${dict[${letter_hold[${i}]}]}
			else
				new_word=${new_word}${letter_hold[${i}]}
			fi
		fi
	done
	new_words+="$new_word "
	((count++))
done

range_begin=1
range_end=2
if [ ${user_input_word_length} -gt 3 ]
then
	while [ $count -gt $user_input_word_length ] && [ $count -lt $combinations ]
	do
		if [ ${range_end} -le ${user_input_word_length} ]
		then
			new_word=""
			for i in $(seq ${user_input_word_length})
			do
				if [ $i -ge $range_begin ] && [ $i -le $range_end ]
				then
					new_word=${new_word}${dict[${letter_hold[${i}]}]}
				else
					new_word=${new_word}${letter_hold[${i}]}
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

##################################
range_begin_two=1
range_end_two=3
if [ ${user_input_word_length} -gt 3 ]
then
	while [ $count -gt $user_input_word_length ] && [ $count -lt $((${combinations}*6)) ]
	do
		if [ ${range_end_two} -le ${user_input_word_length} ]
		then
			new_word=""
			for i in $(seq ${user_input_word_length})
			do
				if [ $i -eq $range_begin_two ] || [ $i -eq $range_end_two ]
				then
					new_word=${new_word}${dict[${letter_hold[${i}]}]}
				else
					new_word=${new_word}${letter_hold[${i}]}
				fi
			done
			new_words+="$new_word "
		fi
		((count++))
		if [ $range_end_two != ${user_input_word_length} ]
		then
			((range_end_two++))
		elif [ $range_begin_two != $((${user_input_word_length}-2)) ]
		then
			((range_begin_two++))
			range_end_two=$((${diction_two[character_position]}+1))
			diction_two[character_position]=$range_end_two
		else
			break
		fi
	done	
fi
###############################
for i in ${new_words}
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
	new_words+="$new_word "
done
test=$(for i in ${new_words}; do echo ${i}; done | sort | uniq)
echo $test
echo $count