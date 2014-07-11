export ORIGINAL="$1"
export CNAME="$2"
export CMAIL="$3"

git filter-branch -f --env-filter "
if test \"\$GIT_AUTHOR_EMAIL\" = \"$ORIGINAL\"
then
    export GIT_AUTHOR_EMAIL=\"$CMAIL\"
    export GIT_AUTHOR_NAME=\"$CNAME\"
fi
if test \"\$GIT_COMMITTER_EMAIL\" = \"$ORIGINAL\"
then
    export GIT_COMMITTER_EMAIL=\"$CMAIL\"
    export GIT_COMMITTER_NAME=\"$CNAME\"
fi
" -- --all
