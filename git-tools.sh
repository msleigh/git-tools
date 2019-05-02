# Prefer:
#     name () { function_body }
# syntax over:
#     function name { function_body }
# syntax, as it gives consistent behaviour in both bash and ksh.

git_merged_tags () {
    # Lists tags that are reachable from the current HEAD or branch name
    # provided, in a particular format
    BRANCH="${1:-"HEAD"}"
    git tag                                \
      --sort='-refname'                    \
      --sort='-creatordate'                \
      --format='%(refname),%(creatordate)' \
      --merged                             \
      "${BRANCH}"
}


git_branch_name () {
    # Echo the current branch name
    git rev-parse --abbrev-ref HEAD
}


git_type_of () {
    # Say whether the provided ref is a branch, tag, remote branch or hash
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


git_repo_path () {
    # Give the path to the .git directory
    # Works in a normal or bare Git repo or in a worktree
    readlink -f "$(git rev-parse --git-common-dir)"
}


git_repo_name () {
    # Give the name of the repository
    # Works in a normal or bare Git repo or in a worktree
    # Don't use rev-parse --is-bare-repository as it returns false if inside
    # worktree of a bare repository; we want true
    if [[ $(git config core.bare) == "true" ]] ; then
        basename "$(git_repo_path)" .git
    else
        GIT_REPO_PATH="$(git_repo_path)"
        basename "${GIT_REPO_PATH%/.git}"
    fi
}

ref_exists () {
    # Verify that the ref exists
    typeset REF="${1:-""}"
    if [[ -z ${REF} ]] ; then
        echo "Missing ref name" >&2
        return 1
    fi
    git rev-parse --quiet --verify "${REF}" >/dev/null
}

git_push_dest () {
    typeset BRANCH="${1:-}"
    if [[ -z ${BRANCH} ]] ; then
        echo "Missing branch name" >&2
        return 1
    fi
    git rev-parse --quiet --verify --abbrev-ref "${BRANCH}@{push}"
}
