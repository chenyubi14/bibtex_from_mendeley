# library.bib is exported from the Mendeley software

if [ $1 ];then
    target=$1
    echo 'the file to be editted is' $target
else
    echo 'Should enter the bib filename exported from Mendeley'
    exit
fi

file=${target}.corr

## remove unnecessary keywords
sed '/pmid = {/d;/file = {/d;/abstract = {/d;/keywords = {/d' $target > $file
## replace doi with url
sed -i '' 's,doi = {,url = {https://doi.org/,g' $file 
## change generic, report, to article
sed -i '' 's/@generic/@article/g;s/@report/@article/g' $file


folder=` dirname $0`
#python $SCRIPT/abbreviate/abbreviate.py $file 
if [[ -f $folder/journal_list.txt && -f $folder/abbreviate.py ]];then
    echo 'abbreviate journal names...'
    python $folder/abbreviate.py  $folder/journal_list.txt $file
else
    #echo 'journal_list.txt or abbreviate.py is not in folder' $folder
    echo 'expect these two files (journal_list.txt and abbreviate.py) are in the same folder' $folder
    echo 'Replace these two files, and run again'
fi

#cat $file


