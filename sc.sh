
#!/bin/bash

#Enter and create directory

echo "Enter name Directory"
read nameDirectory
echo "You Directory - $nameDirectory"
mkdir /home/script_bash/$nameDirectory


#Create files


for i in {1..10}
do
 touch /home/script_bash/$nameDirectory/File$i.txt
done

#Enter date in files

for i in {1..10}
do
 date > /home/script_bash/$nameDirectory/File$i.txt
done
#TEST commit123
