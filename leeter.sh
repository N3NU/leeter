#! /usr/bin/bash

#modules


#variables
declare -A dict=( \
[A]=4 [a]=4 [B]=8 [b]=8 [C]=c [c]=c [D]=d [d]=d [E]=3 [e]=3 [F]=f [f]=f [G]=9 [g]=9 \
[H]=h [h]=h [I]=1 [i]=1 [J]=j [j]=j [K]=k [k]=k [L]=1 [l]=1 [M]=m [m]=m [N]=n [n]=n \
[O]=0 [o]=0 [P]=p [p]=p [Q]=q [q]=q [R]=2 [r]=2 [S]=5 [s]=5 [T]=7 [t]=7 [U]=u [u]=u \
[V]=v [v]=v [W]=w [w]=w [X]=x [x]=x [Y]=y [y]=y [Z]=2 [z]=2 ) 

#48cd3f9h1jk1mn0pq257uvwxy2
#user prompt
read -p "Please enter word to leet: " user_input


#code
for i in $(grep -o . <<< "$user_input")
do
	echo $i
done
