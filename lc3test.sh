for filename in *; do
      if [[ "$filename" == *".asm" ]]; then
            output=$(lc3as $filename 2>&1)
            # Check if the word 'fail' is in the output
            if echo "$output" | grep -q ":"; then
                  echo "$output"
                  echo "Aborting program. "
                  # Terminate the program
                  exit 
            # If 'fail' is not found, do not display the output and continue
            fi
      fi
done

ifsuccess=1
for filename in *; do
      if [[ "$filename" != *"."* ]] && [[ "$filename" != *"out" ]] && [[ "$filename" != *"myresult"* ]]; then
            lc3sim -s $filename > my_out
            diff my_out ${filename}out > /dev/null 2>&1
            if [[ $? -eq 0 ]]; then
                  echo "testing $filename...passed"
            else
                  echo "testing $filename...FAILED"
                  ifsuccess=0
            fi
      fi
done

if [ $ifsuccess == 1 ]; then
      echo "All tests passed successfully!"
else
      echo "Some tests failed."
fi