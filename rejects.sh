#!/bin/bash

# 1️⃣ printf
printf "Welcome to the Bash demo script!\n\n"

# 2️⃣ For loop
echo -e "\nCounting from 1 to 5 using a for loop:"
for i in {1..5}; do
    echo "Number: $i"
done

# 3️⃣ Arrays
fruits=("Apple" "Banana" "Cherry")
echo -e "\nFruits in the array:"
for fruit in "${fruits[@]}"; do
    echo "- $fruit"
done


# 5️⃣ Redirects
echo -e "\nRedirecting output to a file called output.txt"
echo "This is saved to a file!" > output.txt
echo "Appending more text..." >> output.txt
echo "Contents of output.txt:"
cat output.txt
