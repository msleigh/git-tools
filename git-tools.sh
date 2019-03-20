function git_merged_tags {
    BRANCH="${1:-"HEAD"}"
    git tag                                \
      --sort='-refname'                    \
      --sort='-creatordate'                \
      --format='%(refname),%(creatordate)' \
      --merged                             \
      "${BRANCH}"
}


function git_branch_name {
    git rev-parse --abbrev-ref HEAD
}


function git_type_of {
    REF="${1:-""}"
    if [[ -z ${REF} ]] ; then
        echo "Missing ref name" >&2
        return 1
    fi
    if   git show-ref -q --verify "refs/heads/${REF}"   2>/dev/null ; then
        echo "branch"
    elif git show-ref -q --verify "refs/tags/${REF}"    2>/dev/null ; then
        echo "tag"
    elif git show-ref -q --verify "refs/remotes/${REF}" 2>/dev/null ; then
        echo "remote branch"
    elif git rev-parse --verify "${REF}^{commit}" >/dev/null 2>&1 ; then
        echo "hash"
    else
        echo "unknown"
    fi
    return 0
}
