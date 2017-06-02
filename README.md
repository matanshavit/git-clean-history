## git-clean-history

A script for cleaning history of removed files, typically for when splitting a monolith into sub-services, while maintaining relevant commit history.

Todo:
 - [ ] Limit each pass to a max of 250k characters (approx unix limit)
 - [ ] Check allFilesCount and keepFileCount after wards, and repeat for missing files
