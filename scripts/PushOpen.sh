echo 'Pushing source to your default scratch org (times out after 5 minutes)'
sfdx force:source:push -w 5
echo 'Opening your default scratch org'
sfdx force:org:open

# Section that's a loop, you can use this if you want to repeat certain things

: '
counter=1
while [ $counter -le 10 ]
do
echo $counter
((counter++))
done
echo All done 
'
