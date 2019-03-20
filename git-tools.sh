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
