#lc3as mp2.asm
for filename in *; do
      {
      if [[ "$filename" == *".asm" ]]; then
            lc3as $filename
      fi
      } &> /dev/null
      
      if [[ "$filename" != *"."* ]] && [[ "$filename" != *"out" ]] && [[ "$filename" != *"myresult"* ]]; then
            echo "Testing $filename"
            lc3sim -s $filename > my_out
            diff my_out ${filename}out > /dev/null 2>&1
            if [[ $? -eq 0 ]]; then
                  echo "Test succeeded"
            else
                  echo "Test failed"
            fi
      fi
done
