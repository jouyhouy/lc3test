#lc3as mp2.asm
for filename in *; do
      {
      if [[ "$filename" == *"."* ]]; then
            lc3as $filename
      fi
      } &> /dev/null

      if [[ "$filename" != *"."* ]] && [[ "$filename" != *"out" ]]; then
            echo "Testing $filename"
            lc3sim -s $filename > my_out
            diff my_out ${filename}out > /dev/null 2>&1
            if [[ $? -eq 0 ]]; then
                  echo "Test succeeded\n"
            else
                  echo "Test failed\n"
            fi
      fi
done
