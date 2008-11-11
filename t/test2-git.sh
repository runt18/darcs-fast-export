. lib.sh

create_darcs test2 --darcs-2

rm -rf test2.darcs test2.git
mkdir test2.git
cd test2.git
git --bare init
cd ..
if [ "$1" != "--stdout" ]; then
	../darcs-fast-export.py test2 |(cd test2.git; git fast-import)
	if [ $? = 0 ]; then
		git clone -q test2.git test2.git.nonbare
		diff --exclude _darcs --exclude .git --exclude '*-darcs-backup*' -Naur test2.git.nonbare test2
		ret=$?
		rm -rf test2.git.nonbare
		exit $?
	fi
else
	../darcs-fast-export.py test2
fi