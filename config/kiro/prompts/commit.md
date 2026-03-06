Create Git Commit with staged changes.
Write a commit message that describes the changes being committed.

```bash
git status
git diff --cached
```

The commit message should be concise and informative, providing context for the changes made. "WHY" is good questions to answer in the commit message. "WHAT" is not as important, as the diff will show the details of the changes.

When making git commits, always use this form:

```bash
GIT_AUTHOR_NAME="Kiro CLI" \
GIT_AUTHOR_EMAIL="kiro-cli@dev.local" \
GIT_COMMITTER_NAME="Kiro CLI" \
GIT_COMMITTER_EMAIL="kiro-cli@dev.local" \
git commit -m "..."
```
