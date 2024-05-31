Steps to make sv-lib as a git submodule 
```
git clone git@github.com:d4u-b/sv-otu2.git
cd sv-otu2
git submodule add git@github.com:d4u-b/sv-lib.git sv-lib
git commit -am "Update sv-lib submodule"
git push origin main 
```

Steps to clone a repo with submodule inside
```
git clone git@github.com:d4u-b/sv-otu2.git
cd sv-otu2
git submodule update --init --recursive
```

Pull changes from submodule repo
```
git submodule update --remote --merge
```
Or
```
cd sv-otu2/sv-lib
git pull origin main
```

Commit changes in submodule
```
cd sv-otu2/sv-lib
git add <files>
git commit -m "Update submodule"
```

