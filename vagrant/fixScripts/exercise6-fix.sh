#!/bin/bash
copy_files () {
   array=("$@")
   last_idx=$(( ${#array[@]} - 1 ))
   dest_path=${array[$last_idx]}
   if [ ${#array[@]} -lt 2 ]; then
      echo -e "Please provide at least two arguments:\nThe first arguments should be the paths to source files and the last one should be the destination path"
   else
      files_paths=""
      for (( i = 0; i < $((${#array[@]} - 1 )); i++ )); do
         files_paths+="${array[$i]} "
      done
      if [ "$HOSTNAME" = "server1" ]; then
         dest_host="server2"
         secure_copy
      else
          dest_host="server1"
          secure_copy
      fi
   fi
}

secure_copy (){
  echo "Starts copying the following files into [$dest_path] on $dest_host:"
       scp $files_paths@$dest_host:$dest_path
       scp_return_val=$?
        if [ $scp_return_val -eq 0 ]; then
          echo "Copying completed successfully!"
          bytes_calc
        else
          echo "Oops! Something went wrong - Copying was NOT completed successful"
        fi
}

bytes_calc () {
  for file in $files_paths; do
         if [[ -f $file ]]; then
                  ((size+=$(stat -c%s "$file")))
         fi
  done
  echo "$size"
}

copy_files "$@"