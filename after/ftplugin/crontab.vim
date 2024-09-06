" From Vim 6.3's :help crontab
"   One situation where "no" and "auto" will cause problems: A program that
"   opens a file, invokes Vim to edit that file, and then tests if the open
"   file was changed (through the file descriptor) will check the backup file
"   instead of the newly created file. "crontab -e" is an example.
setlocal backupcopy=yes
