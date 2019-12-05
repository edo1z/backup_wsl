#!/bin/bash

today=$(date +%Y%m%d)
target_dir=/mnt/c/backup/wsl
tmp_dir=backup_wsl_tmp
origin_dir=/
target_today_dir=$target_dir/$today
target_today_tarfile=$target_today_dir/backup.tar.bz2
exclude_list=exclude_list.txt
save_files_number=5

echo '[Create WSL backup files]'
echo 'creating backup file...'
echo '--------------------------'
mkdir -p $target_today_dir
tar -cvpjf $target_today_tarfile -X $exclude_list $origin_dir
echo '--------------------------'

echo 'creating backup directories...'
rm -rf $tmp_dir
mkdir -p $tmp_dir
dir_str="${target_dir}/*/"
count=1
for dirname in $(ls -td $dir_str); do
	mv $dirname $tmp_dir
	count=$((++count))
	if [ $count -gt $save_files_number ]; then
		break
	fi
done
rm -rf $target_dir
mv $tmp_dir $target_dir
echo '[SUCCESS] Created backup files!!'
