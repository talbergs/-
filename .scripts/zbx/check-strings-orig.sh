#!/bin/sh
#| Check translation strings.
#| Script must be run from within git repo.
#|
#| Usage:
#|    check-strings <sha-then> <sha-now>
#|
#| Example:
#|    check-strings $(git rev-parse HEAD^) $(git rev-parse HEAD)
#|    check-strings $(git rev-parse <sha>^) <sha>
#|
[[ $# -ne 2 ]] && grep '^#|' $0 | sed 's/^#//' && exit 0

# branch=svn://svn.zabbix.com/$1
templ=frontends/php/locale/en_US/LC_MESSAGES/frontend.po

if [ $# -eq 0 ]
then
	echo "No arguments supplied"
	echo ""
	echo "Usage:"
	echo -e "\t${0##*/} <branch> <rev_from> [<rev_to>]"
	echo ""
	echo "Example:"
	echo -e "\t./${0##*/} trunk 53559"
	exit
fi

# if [ -z "$3" ]
# then
# 	let "rev1=$2-1"
# 	rev2=$2
# else
	rev1=$2
	rev2=$1
# fi


rm -rf /tmp/zabbix.*

d=$PWD

git archive $rev1 > /tmp/zabbix.$rev1.tar
mkdir /tmp/zabbix.$rev1
cd /tmp/zabbix.$rev1
tar -xf /tmp/zabbix.$rev1.tar

cd $d

git archive $rev2 > /tmp/zabbix.$rev2.tar
mkdir /tmp/zabbix.$rev2
cd /tmp/zabbix.$rev2
tar -xf /tmp/zabbix.$rev2.tar

cd $d

# svn co $branch/frontends/php /tmp/zabbix.$rev1 -$rev1 -q &
# pid1=$!
# svn co $branch/frontends/php /tmp/zabbix.$rev2 -$rev2 -q &
# pid2=$!
# wait $pid1
# wait $pid2

/tmp/zabbix.$rev1/frontends/php/locale/update_po.sh 2>&1 > /dev/null &
pid1=$!
/tmp/zabbix.$rev2/frontends/php/locale/update_po.sh 2>&1 > /dev/null &
pid2=$!
wait $pid1
wait $pid2

# Removing location comments guarantees consistent order of "msgctxt" and "msgid" lines in resulted diff when context is added to a string.
# Correct diff order for new context strings is also is guaranteed only if in rev2 new string is untranslated,
# but in rev1 the same string but without context is translated!
# en_US locale is the best candidate in such case, as most likely it has all lines translated (duplicated)
msgattrib --no-obsolete --no-wrap --sort-output --no-location /tmp/zabbix.$rev1/$templ -o /tmp/zabbix.$rev1/$templ
msgattrib --no-obsolete --no-wrap --sort-output --no-location /tmp/zabbix.$rev2/$templ -o /tmp/zabbix.$rev2/$templ

echo -n -e 'Strings added:\n\n' > /tmp/zabbix.$rev1.$rev2
diff /tmp/zabbix.$rev1/$templ /tmp/zabbix.$rev2/$templ | egrep '> (msgid|msgctxt)' >> /tmp/zabbix.$rev1.$rev2
echo -n -e '\nStrings deleted:\n\n' >> /tmp/zabbix.$rev1.$rev2
diff /tmp/zabbix.$rev1/$templ /tmp/zabbix.$rev2/$templ | egrep '< (msgid|msgctxt)' >> /tmp/zabbix.$rev1.$rev2

# echo "Unmodified:"; cat /tmp/zabbix.$rev1.$rev2; echo ""

sed -ri '/[<>] msgctxt/ {:a;N;s/[<>] msgctxt "(.+)"\n[<>] msgid "(.+)"/- _\2_ *context:* _\1_/g}' /tmp/zabbix.$rev1.$rev2
sed -ri 's/^(<|>) msgid(_plural){0,1} "/- _/g' /tmp/zabbix.$rev1.$rev2
sed -ri 's/"$/_/g' /tmp/zabbix.$rev1.$rev2
sed -ri 's/\\"/"/g' /tmp/zabbix.$rev1.$rev2

echo "" >> /tmp/__original
echo "" >> /tmp/__original
echo "====================" >> /tmp/__original
echo "$rev1..$rev2" >> /tmp/__original
echo "--------------------" >> /tmp/__original
cat /tmp/zabbix.$rev1.$rev2 | sed '/^$/d' >> /tmp/__original
cat /tmp/zabbix.$rev1.$rev2

rm -rf /tmp/zabbix.$rev1 /tmp/zabbix.$rev2 /tmp/zabbix.$rev1.$rev2
