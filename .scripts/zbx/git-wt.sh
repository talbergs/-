#!/bin/bash

# This script provides commands to update and cleanup fit working
# tree structure:
#
# $GITROOT/
#     master/ 
#     feature/
#         ZBX-123/
#         DEV-456/
#         ZBXNEXT-789/
#         ...
#     release/
#         3.0/
#         4.0/
#         4.2/
#         ...
#     tag/
#         3.0.8/
#         4.0.3/
#         4.2.1/
#         ...
#
# Before using set the correct GITROOT, GITREPO variables below and clone the
# Zabbix repository in GITREPO directory.
#
# Usage: git-wt.sh <command> <parameters>
# Where command:
#   update <target>
#     Checks out all branches related to the <target> into worktree. The
#     target can be either Jira issue number (ZBX-123, DEV-456, ZBXNEXT-789),
#     or branch (4.0, 4.2) or version number (3.0.6, 4.2.1). 
#     After checkout git_add_worktree_hook() function is called (if exists)
#     with target directory as parameter to allow creation of post update hooks.
#
#   clean <directory>
#     Removes all working tree directories matching the <directory> base name
#     (Jira issue, branch or version without suffixes).
#     After checkout git_remove_worktree_hook() function is called (if exists)
#     with target directory as parameter to allow creation of post cleanup hooks.
#
#   log [<options>]
#    Shows commits done in the current feature branch. By default --oneline option
#    is used which can be overriden by passing other options.
#
#   logv [<options>]
#    Shows commits done in the current feature branch in verbose format. By default
#    --oneline option is used which can be overriden by passing other options.
#
#   diff
#    Shows changes done in the current feature branch.
#
#   wdiff
#    Shows changes done in the current feature branch using dwdiff.
#
#   ref-dir <target>
#    Displays worktree directory associated to the latest <target> branch/tag. Can
#    be used to change working directory after update.
#
#   root 
#    Displays $GITROOT varibale.
#
#   create-feature [<source>] <issue>
#     Creates new feature branch from <source> branch for the Jira <issue> and pushes
#     it to the remote repository:
#       <source> - the source branch (4.0, 4.2, master is used by default)
#       <issue> -  the Jira issue number (ZBX-123, DEV-456, ZBXNEXT-789)
#     The source suffix will be automatically added. 
#
# Examples:
#   ./git-wt.sh update 4.0
#     Checks out release/4.0 branch in $GITROOT/release/4.0/
#
#   ./git-wt.sh update 4.2.1
#     Checks out 4.2.1 tag in $GITROOT/tag/4.2.1/
#
#   ./git-wt.sh update ZBXNEXT-2033
#     Checks out all feature branche created for ZBXNEXT-2033:
#       $GITROOT/feature/ZBXNEXT-2033/
#       $GITROOT/feature/ZBXNEXT-2033_224/
#       $GITROOT/feature/ZBXNEXT-2033_244/
#       $GITROOT/feature/ZBXNEXT-2033_303/
#       $GITROOT/feature/ZBXNEXT-2033_32/
#       $GITROOT/feature/ZBXNEXT-2033_342/
#       $GITROOT/feature/ZBXNEXT-2033_349/
#
#   cd $(./git-wt.sh ref-dir ZBXNEXT-2033)
#     Changes current directory to $GITROOT/feature/ZBXNEXT-2033_349/
#
#   ./git-wt.sh clean ZBXNEXT-2033_349
#     Removes ZBXNEXT-2033* subdirectories from feature directory.
#
#   ./git-wt.sh create-feature DEV-1500
#     Creates feature branch feature/DEV-1500-4.3 from master and pushes it
#     to the remote repository.
#
#   ./git-wt.sh create-feature 4.0 ZBX-1500
#     Creates feature branch feature/DEV-1500-4.0 from release/4.0 branch and 
#     pushes it to the remote repository.
#
# Note this script will tag ace160995fe913495108cad01ce12cfded7b74a5 commit as 4.3.0 
#

if [ $(whoami) == 'mt' ];then
	GITROOT="$HOME/NEW_FLOW/data/www/zabbix"
else
	GITROOT="$HOME/WORKFLOW_PATH/docker-box/data/www/zabbix"
fi

GITREPO="$GITROOT/master"

GITFEATURE="$GITROOT/feature"
GITRELEASE="$GITROOT/release"
GITTAG="$GITROOT/tag"

GITMASTER_VERSION="4.3"

git_init_env()
{
	if [ ! -d "$GITROOT" ]; then
		echo "Cannot access git workspace directory $GITROOT"
		return 1
	fi
	
	if [ ! -d "$GITREPO" ]; then
		echo "Cannot access git repository directory $GITREPO"
		return 1
	fi
	
	if [ ! -d "$GITFEATURE" ]; then
		mkdir "$GITFEATURE"
	fi

	if [ ! -d "$GITRELEASE" ]; then
		mkdir "$GITRELEASE"
	fi

	if [ ! -d "$GITTAG" ]; then
		mkdir "$GITTAG"
	fi

	# set 4.3.0 tag to master branch after 4.2.0 was released
	#pushd "$GITREPO" > /dev/null
	#if ! git rev-parse 4.3.0 > /dev/null; then
	#	git tag 4.3.0 ace160995fe913495108cad01ce12cfded7b74a5
	#fi
	#popd > /dev/null
	
	return 0
}

git_make_ref()
{
	case $1 in
		DEV-*|ZBX-*|ZBXNEXT-*)
			echo "feature/$1"
			;;
		2.0|2.2|3.0|4.0|4.2)
			echo "release/$1"
			;;
		"")
			echo "master"
			;;
		*)
			echo "tag/$1"
			;;
		
	esac
}

git_validate_ref()
{
	if [[ "$1" =~ ^feature/(ZBX|ZBXNEXT|DEV)-[0-9]+$ ]]; then
		return 0
	fi
	
	if [[ "$1" =~ ^release/[0-9]\.[0-9]$ ]]; then
		return 0
	fi

	if [[ "$1" =~ ^tag/[0-9]\.[0-9]\.[0-9]$ ]]; then
		return 0
	fi

	return 1
}

git_add_worktree()
{
	if [ -d "$GITROOT/$1" ]; then
		echo "Worktree directory $1 already exists"
		return
	fi
	
	git worktree add "$GITROOT/$1" "$2"

	if type -t git_add_worktree_hook > /dev/null; then
		git_add_worktree_hook "$GITROOT/$1" "$2"
	fi
}

git_remove_worktree()
{
	if type -t git_remove_worktree_hook > /dev/null; then
		git_remove_worktree_hook "$GITROOT/$1"
	fi
	
	rm -rf "$GITROOT/$1"
	git worktree prune
	
}

git_update()
{
	if ! git_init_env; then
		exit 1 
	fi
	
	if [ -z "$1" ]; then
		echo "Usage: git-wt.sh update <ZBX-123|DEV-123|ZBXNEXT-123|<branch>|<tag>>"
		exit 1
	fi

	local REF=$(git_make_ref "$1")
	if ! git_validate_ref "$REF"; then
		echo "Invalid git reference $REF"
		exit 1
	fi

	cd "$GITREPO"
	git pull

	if [ "${REF%%/*}" == "tag" ]; then
		git_add_worktree "$REF" "${REF##*/}"
	else
		git branch -r | grep "$REF" | sort | while read LINE; do
			REF="${LINE#*/}"
			if [ ! -d "$GITROOT/$REF" ]; then
				if ! git branch | grep "$REF\$" > /dev/null 2>&1; then
					git branch --track "$REF" "origin/$REF"
				fi
				git_add_worktree "$REF" "$REF"
			fi
		done
	fi
}


git_get_directory_ref()
{
	local REF=$(pwd)
	REF="${REF##*/}"
	
	if [[ "$REF" =~ (ZBX|ZBXNEXT|DEV)-([0-9]+) ]]; then
		REF="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"
	fi
	
	echo "$REF"
}

git_clean()
{
	if ! git_init_env; then
		exit 1 
	fi

	if [ -z "$1" ]; then
		echo "Usage: git-wt.sh clean <directory>"
		exit 1
	fi

	local REF=$(git_make_ref "$1")
	
	if ! git_validate_ref "$REF"; then
		echo "Invalid git reference $REF"
		exit 1
	fi
	
	cd "$GITREPO"
	
	if [ "${REF%%/*}" == "tag" ]; then
		git_remove_worktree "$REF" "${REF##*/}"
	else
		find "$GITROOT" -maxdepth 2 -name "${REF##*/}*" \
				-exec realpath --relative-to "$GITROOT" {} \; | while read LINE; do
			git_remove_worktree "$LINE"
			git branch -D $LINE 
		done
	fi
}	

git_get_ref_dir()
{
	local REF=$(git_make_ref "$1")
	find "$GITROOT" -maxdepth 2 -name "${REF##*/}*" | sort | tail -n1
}

git_get_parent_by_tag()
{
	local TAG=$(git describe --tags --abbrev=0 --first-parent)
	
	if [[ ! "$TAG" =~ ^([0-9])\.([0-9])\.([0-9])(.*)$ ]]; then
		return 1
	fi
	
	if [ "${BASH_REMATCH[3]}" == "0" ] && [ -n "${BASH_REMATCH[4]}" ]; then
		echo "master"
	else
		case ${BASH_REMATCH[2]} in
			1|3|5|7|9)
				echo "master"
				;;
			*)
				echo "release/${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
				;;
		esac
	fi

	return 0
}

git_get_parent()
{
	local CHANGES=$(grep 'Changes for' ChangeLog | head -n1 2>/dev/null)
	
	if [ -z "$CHANGES" ]; then 
		git_get_parent_by_tag
		return $?
	fi
	
	if [[ ! "$CHANGES" =~ ([0-9])\.([0-9])\.([0-9])(.*)$ ]]; then
		git_get_parent_by_tag
		return $?
	fi
	
	local VERSION="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}"
	if [ "$VERSION" == "4.4" ]; then
		echo "master"
	else
		echo "release/$VERSION"
	fi

	return 0
}

git_verify_parent()
{
	local DIR=$(pwd)
	
	
	if [[ ! "${DIR##*/}" =~ (DEV|ZBX|ZBXNEXT)-[0-9]+-([0-9])\.([0-9]) ]]; then
		echo "Warning, cannot extract upstream branch version from directory name"
		return 1
	fi
	
	case ${BASH_REMATCH[3]} in
		1|3|5|7|9)
			local PARENT="master"
			;;
		*)
			local PARENT="release/${BASH_REMATCH[2]}.${BASH_REMATCH[3]}"
			;;
	esac

	if [ "$1" != "$PARENT" ]; then
		echo "Warning, detected parent $1 does not match directory ${DIR##*/} ($(git describe --tags --abbrev=0 --first-parent))"
		return 1
	fi
	
	return 0
}

git_log()
{
	local PARENT=$(git_get_parent)
	if [ $? -ne 0 ]; then
		echo "Cannot determine parent branch"
		exit 1
	fi
	
	local OPTIONS="$@"
	if [ -z "$OPTIONS" ]; then
		OPTIONS="--oneline"
	fi
	
	eval git log $PARENT.. $OPTIONS
}

git_logv()
{
	local PARENT=$(git_get_parent)
	if [ $? -ne 0 ]; then
		echo "Cannot determine parent branch"
		exit 1
	fi
	
	OPTIONS="--oneline --date=short --format='%C(auto,yellow)%h%C(auto,magenta)% G? %C(auto,blue)%>(10,trunc)%ad %C(auto,green)%<(20,trunc)%aN%C(auto,reset)%s%C(auto,red)% gD% D'"
	
	eval git log $PARENT.. $OPTIONS $@
}

git_diff()
{
	local PARENT=$(git_get_parent)
	if [ $? -ne 0 ]; then
		echo "Cannot determine parent branch"
		exit 1
	fi
	
	local COMMIT=$(git merge-base --fork-point $PARENT)
	
	if [ -z "$COMMIT" ]; then
		COMMIT=$(git_log --oneline $PARENT.. | tail -n1 | cut -f1 -d ' ')
	fi
	
	git diff $COMMIT
}

git_wdiff()
{
	git_diff | dwdiff --color=red,green -d '=,;()^|&*[]{}.""-<>' --diff-input -S-- | less -R
}

git_create_feature()
{
	shift
	
	if [ -z "$2" ]; then
		local REF="master"
		local BRANCH="feature/$1-$GITMASTER_VERSION"
		local ISSUE=$1
	else
		local REF="release/$1"
		local BRANCH="feature/$2-$1"
		local ISSUE=$2
	fi
	
	if [[ ! "$BRANCH" =~ ^feature/(DEV|ZBX|ZBXNEXT)-[0-9]+-[0-9]\.[0-9]$ ]]; then
		echo "Invalid source branch $SOURCE"
		exit 1
	fi
	
	cd "$GITREPO"
	git fetch -p
	
	if git branch | grep "$BRANCH" > /dev/null; then
		echo "Local branch $BRANCH already exists"
		exit 1
	fi

	if git branch -r | grep "$BRANCH" > /dev/null; then
		echo "Remote branch $BRANCH already exists"
		exit 1
	fi

	if ! git branch "$BRANCH" "origin/$REF"; then
		exit 1
	fi
	
	if ! git push -u origin "$BRANCH"; then
		exit 1
	fi
	
	git_update $ISSUE
}

git_pull_upstream()
{
	local PARENT=$(git_get_parent)
	if [ $? -ne 0 ]; then
		echo "Cannot determine parent branch"
		exit 1
	fi
	
	if ! git_verify_parent $PARENT; then
		echo "Pulling changes from unverified upstream branch $PARENT"
	fi
	
	git pull origin "$PARENT" $@
}

git_latest_dev_branch()
{
	cd $GITREPO
	git branch -r | grep "$REF" | sort -r | head -n1
}

case $1 in 
	up|update)
		git_update $2
		;;
	cl|clean)
		git_clean $2
		;;
	log)
		shift
		git_log $@
		;;
	logv)
		shift
		git_logv $@
		;;
	diff)
		git_diff
		;;
	wdiff)
		git_wdiff
		;;
	ref-dir)
		git_get_ref_dir $2
		;;
	root)
		echo "$GITROOT"
		;;
	create-feature)
		git_create_feature $@
		;;
	pull-upstream)
		shift
		git_pull_upstream $@
		;;
	parent)
		shift
		git_get_parent
		;;
	*)
		echo "Usage $0 <command> [<issue|version|tag>]"
		;;

esac

exit 0
