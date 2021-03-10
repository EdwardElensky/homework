## Geting started
This script checks open pull requests for a repository, show autor and title of pr. 

## Requirements
* Linux 
* bash
* curl
* jq

## Usage
Start script with url of repo ` ./pr-git.sh https://github.com/$user/$repo `
Example `./pr-git.sh https://github.com/stellar/go `

## How it work

* Get name and repo from url $1
* Prepare url https://api.github.com/repos/$name/$repo/pulls?q=state%3Aopen for download
* Download pulls.json file  from Github API (use curl)
* use jq and get from downloaded file userlogin and show (after sort and grep)
* use jq for get title of pr
* show title for each users




## Unleash your creativity with GitHub
* write a script that checks if there are open pull requests for a repository. An url like `https://github.com/$user/$repo` will be passed to the script
* print the list of the most productive contributors (authors of more than 1 open PR)
* print the number of PRs each contributor has created with the labels
* implement your own feature that you find the most attractive: anything from sorting to comment count or even fancy output format
* ask your chat mate to review your code and create a meaningful pull request
* do the same for her xD
* merge your fellow PR! We will see the repo history

### Hints
* [Have a look here](https://github.com/trending) and `curl`
* Hey, why are you not telling us about the scoring?


