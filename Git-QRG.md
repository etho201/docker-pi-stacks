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

### If you already have the repo clones, and branch already exists.
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

### If you want to omit any folders from syncing, do the following:
```bash
git init
git remote add -f origin <url>
git config core.sparsecheckout true
echo <omit-dir1>/ >> .git/info/sparse-checkout
echo <omit-dir2>/ >> .git/info/sparse-checkout
git pull origin master
```