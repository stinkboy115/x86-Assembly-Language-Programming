Develop an x86 Assembly Language Program. You will build an application program as described in the steps next:

1. Hard code (into the DATA segment) the related data given in this step for the use of this
application: initialize a table (may use 2D array) containing ten entries where each entry will
be an assumed student names along with an assumed respective numerical grade (in
integers) for each student. (hint: you may use nested loop to navigate the data; also, do not
forget to keep student name and respective grade pair intact while manipulating the table
data).

2. Note: all implementation of your program from this point onward goes in the Code segment.
Sort (in descending order) the entries of the assumed table above with respect to the
numerical grade. Your team MUST use and implement Selection Sort (provided a quick
reference next; a standard sorting algorithm that you may have studied or can easily find
online) for this and allocate a new memory area for fully sorted table at the end of sorting.

3. Assign letter grade to individual entry based on the numerical grade as defined below:
90+  A
80+  B
70+  C
60+  D
59‐  F

4. Count the number of each letter grades and print them out in alphabetical order as
described next: If there are 3 A’s, 4 B’s, 1 C’s, 0 D’s, and 2 F’s, then print out “34102”.
