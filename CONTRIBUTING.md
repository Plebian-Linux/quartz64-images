How To Contribute
=================

This document describes the guidelines for contributions.


## Commit Messages

Wrap them at 70-75 characters. Prefix the subject with a fitting prefix, run
`git log -- fileyouchanged` to get an idea of what was used previously. It's not
always consistent, so just try your best. For nested directories, use a slash to
separate them, e.g. `debos/scripts: Add script to foo the bar`. The prefix
should reflect the main nature of the change; also having the script be run in
the same change with a 3 liner is fine.

The subject should be present tense, first letter after the prefix is
capitalised. Follow it up with an empty line and a longer description of the
commit if appropriate.


## Commit Scope

Commits should be mostly self-contained, and preferably not break builds during
bisects. That means that I should be able to check out any commit in the
repository and the build should still finish.

Do not lump unrelated changes into one commit. Small one-line commits are fine,
adding a feature and fixing a typo in HACKING.md in one and the same commit is
not. As stated previously, multi-file changes that are actually connected in
some way are okay to be in one and the same commit.


## Pull Requests

Pull requests should generally follow some theme, i.e. be for a specific feature
or improvement. Don't lump unrelated commits together in one pull request unless
the subsequent commits require them to not cause conflicts later down the line.

During the review process, you may be asked to occasionally fix something in
your commit. Instead of pushing another commit to your branch to do this,
rewrite your history as follows:

1. Make your fixup change and commit it (`git commit -m "fixup for foo"`), then
   stash any other changes you still have (`git stash`)
2. Count how many commits back your to-be-fixed up commit is (`git log`)
3. Start an interactive rebase based on this number of commits, e.g. if we need
   to rewrite something 3 commits back (inclusive) do `git rebase -i HEAD~3`
4. Move the line of your fixup commit just after the to-be-fixed up commit, and
   change its prefix to `f` (for fixup). Save the changes and exit.
5. Your history is now re-written, now force-push your PR branch with the
   changes: `git push -f yourremote yourprbranch`.
6. Restore the miscellaneous changes from your stash if you have any:
   `git stash pop`

Sometimes it's necessary to only stage part of your work on a file; for that,
use `git add -p filehere` and then type `?` for instructions.


