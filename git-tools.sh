function git_merged_tags {
    BRANCH="${1:-"HEAD"}"
    git tag                                \
      --sort='-refname'                    \
      --sort='-creatordate'                \
      --format='%(refname),%(creatordate)' \
      --merged                             \
      "${BRANCH}"
}
