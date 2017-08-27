# git-stats-with-bash
Contains bash commands to get statistics across repositories. And visualizing the collected stats using d3.js

# Usage

## To generate no.of lines added/deleted and total by a particular author

### Edit "lines-year.sh" script to add author

**Example**

 Change the opiton --author=<author-name> to --author="sheikirfanbasha@gmail.com"

### Run the command with directory path as argument

**Example**

 ```
 ./lines-year.sh /Users/irfan/Project/
 ```

 *This command will generate "lines-year.json" file*
