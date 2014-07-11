# Some Files to use in Git migration

- `authors-transform.txt` – example of a transformation file for
    `git-svn`, `git-cvsimport`,
    [cvs-fast-export](http://www.catb.org/~esr/cvs-fast-export/) etc.
- `authors.rb` – generate translation file template from log
- `filter-mail-par.sh` – change old IDs to Name + Mail in existing Git
    working copy
- `git-import.sh` – batch import fast import files (`*.fi`)
- `loop-authors.pl` – loop over authors in transformation file and call
    `filter-mail-par.sh`
- `loop-recode.py` – recode commit messages if necessary
