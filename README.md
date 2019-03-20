# git-tools

A collection of handy Git functions.

## Installation

### As a library

The intended use is as a Bash library to source in your own scripts.

1. Clone the repository somewhere
   ```bash
   cd /path/to/destination
   git clone https://github.com/msleigh/git-tools.git
   ```
1. Add the lines to the top of your script, after the shebang but before any
   other executable statement:
   ```bash
   source /path/to/destination/git-tools/git-tools.sh
   ```
1. Use the functions, e.g.:
   ```bash
   echo $(git-current-branch)
   ```

## Contents

### git-current-branch

Echoes the current branch

### git-merged-tags [branch]

Lists tags that are reachable from the provided branch, or from the current
branch if no argument is provided.
