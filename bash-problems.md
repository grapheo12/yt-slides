# Bash Problems for Shell Scripting Workshop

## 1. Finding GCD

Write a shell script which will take any number of integers (comma separated) and output their GCD.


## 2. Sorting and Merging large number of files

You are given a folder with hundreds of text files: [https://cse.iitkgp.ac.in/~mainack/OS/assignments/2021/01/1.b.files.zip](https://cse.iitkgp.ac.in/~mainack/OS/assignments/2021/01/1.b.files.zip)

You need to sort each of these individual files in decreasing order (numerically), write the sorted files in a new **1.b.files.out** folder, and then merge these individual sorted files into a single sorted file (name it **1.b.out.txt**) which is sorted in decreasing order. Write a shell script which iterates over the given files and perform this task.


## 3. Creating frequency distribution from a large file

You have a text file with aroung 1.5M lines ([https://cse.iitkgp.ac.in/~mainack/OS/assignments/2021/01/1c_input.txt.zip](https://cse.iitkgp.ac.in/~mainack/OS/assignments/2021/01/1c_input.txt.zip))

This text files has 4 space separated columns, example of 1 line from the file:

`1 ib Jim 34`


Write a shell script which will take 2 inputs: the input file and a column number.

Convert the contents of the given file to lowercase. Then find the frequency count for each unique entry in that column.


## 4. Create a random password generator

Create a script that generates random passwords of given lengths (taken as arg). Use `/dev/urandom` as your source of randomness.
Allowed characters: Alphanumeric and `_$/`



**CHALLENGE: WRITE THE SHORTEST SCRIPT POSSIBLE** 
