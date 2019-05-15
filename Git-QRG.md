# Git Quick Reference Guide


### First time cloning and new branch.
```bash
git clone PROJECT.git
git checkout -b NEWBRANCH

# make changes

git status
git add -A
git commit -m "commit message"
git push origin NEWBRANCH
```

### If you already have the repo cloned, and branch already exists.
```bash
git checkout master
git pull
git checkout BRANCHNAME
git merge master

# make changes

git status
git add -A
git commit -m "commit message"
git push
```
