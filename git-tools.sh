function git_merged_tags {
    BRANCH="${1:-"HEAD"}"
    git for-each-ref                      \
      --sort='-refname'                   \
      --sort='-authordate'                \
      --format='%(refname),%(authordate)' \
      --merged                            \
      "${BRANCH}" 'refs/tags'
}
