#!/bin/bash

if [ $# -ne 1 ] 
then
    echo "    usage: $0 <assignment marking directory>"
    exit 1
fi

EMPTY=""

# marking file keyword
MARKING_KEYWORD="marking"

# assignment marking directory passed as argument
marking_dir=$1
length=${#1}
last_char_index=$(( length - 1 ))
last_char=${marking_dir:${last_char_index}}

if [ "$last_char" = "/" ]
then
    marking_dir_no_slash=${marking_dir:0:${last_char_index}}
else
    marking_dir_no_slash=${marking_dir}
fi

# acquire the list of files
ls_dir="${marking_dir_no_slash}/*$MARKING_KEYWORD*"
files=$(ls -1 ${ls_dir})
num_files=$(ls -1 ${ls_dir} | wc -l)

if [ "$num_files" -lt 1 ]
then
    echo "Found no marking files in $marking_dir_no_slash"
    exit 1
fi

for student_file in $files; do
    # get the name of file without the full path
    actual_name=$(basename $student_file)
    
    # Split actual name into parts
    OLDIFS=$IFS
    IFS='.'
    file_name_parts=( $actual_name )
    IFS=$OLDIFS

    user_name=${file_name_parts[0]}
    assignment_name=${file_name_parts[1]}
   
    subject="[CS 010] Grading Results For: ${assignment_name}"

    greeting="Your work for ${assignment_name} has been graded. If you have questions please contact your TA or the instructor."

    grade_clarify="Grade Clarification: If you feel you wrongly lost points on a specific test, please inquire during lab or office hours. If your question does not get answered during those periods or you cannot make office hours, please email."

    regrade_policy="Regrade Policy: Asking about a test in lab or office hours does not mean you are asking for a regrade. However if you do ask for a regrade, please note that we are not simply giving back points. Your assignment will be graded again and you will receive this new score, if more incorrect pieces were discovered during further manual or auto grading then your new score may be lower than the original. This policy is primarily designed for student programs that may have been incorrectly auto-marked and the student clearly followed the specification for the assignment as well as the guidelines provided by the TAs or instructor."

    spec="The specification is a starting point for the assignment and most test cases are laid out so that those that followed it will be marked properly. If you did not follow the specification then in the overwhelming majority of cases, you will not get a better grade when asking for a regrade. Assuming something about the specification generally leads to a poor program, you should never assume, it is better to ask for clarification prior to the assignment deadline."

    sig="Adam Koehler\nakoeh001@cs.ucr.edu\nCS 10 TA"

    msg="$greeting \n\n$grade_clarify \n\n$regrade_policy \n\n$spec \n\n$sig"

    if [ "$user_name" = "$EMPTY" ]
    then
        echo "Found an empty username, continuing to next file."
        continue
    fi

    echo -e "$msg" | mutt -s "$subject" -a $student_file ${user_name}@ucr.edu
    echo "Emailing ${user_name}@ucr.edu with ${actual_name} as attachment"
    
    # Do not overload mail server
    sleep 2
done

