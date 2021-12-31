[//]: # (Markdown: dillinger.io/ shows a nice example of Markdown commands with a viewer.)
[//]: # (Comments in Markdown: http://stackoverflow.com/questions/4823468/comments-in-markdown)
[//]: # (C++ Project Structure: http://hiltmon.com/blog/2013/07/03/a-simple-c-plus-plus-project-structure/)
[//]: # (C++ Library Creation: http://www.adp-gmbh.ch/cpp/gcc/create_lib.html)

# Automatic Code Grading

Scripts written in Bash to grade students' C++ programming assignments.
The scripts automatically grade and prints out a detailed report in PDF for
each student, detailing where their code failed.

The scripts, aided with C++ test harnesses, test the OOP classes by first
injecting code (friending my test classes into their classes) into their
code and then testing each class member separately, allowing for partial
credit.

### Installation

```sh
$ git clone <git-repo-url>
$ cd automatic-code-gradinm
$ make
```
### Usage

```sh
$ bin/automatic-code-grading 
```

