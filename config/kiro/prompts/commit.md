Create Git Commit with staged changes.
Write a commit message that describes the changes being committed.

```bash
git status
git diff --cached
```

The commit message should be concise and informative, providing context for the changes made. "WHY" is good questions to answer in the commit message. "WHAT" is not as important, as the diff will show the details of the changes.

When making git commits, always use this form:

```bash
git commit -m "...\n\nCo-Authored-By: Kiro CLI <kiro-cli@dev.local>"
```
