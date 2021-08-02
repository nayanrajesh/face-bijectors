	#!/bin/bash
#Convert face data to ridge data

for i in {3..14}
do
   line=$"m"$i 
   sed -n -e '1,3'p -e  '/ 2/p' /home/nayan/Documents/Polymath/face-bijectors/data/$line$".fac" > $line$"ridge.fac"
done

    
  
