# Unix cat implementation in ruby

`cat `is a Unix utility that accepts input both from command-line arguments
(e.g. filenames) and from the standard input stream.

We can mirror this behavior in Ruby using ARGF and ARGV.

## Examples

```shell
$ ruby cat_argv.rb f1.txt f2.txt
file1
file2

$ echo "STDIN" | ruby cat_argv.rb
STDIN

$ ruby cat_argf.rb f1.txt f2.txt
file1
file2

$ echo "STDIN" | ruby cat_argf.rb
STDIN

$ echo "STDIN" | cat f1.txt - f2.txt
file1
STDIN
file2

$ echo "STDIN" | ruby cat_argv.rb f1.txt - f2.txt
file1
cat_argv.rb:1:in `read': No such file or directory @ rb_sysopen - - (Errno::ENOENT)

$ echo "STDIN" | ruby cat_argf.rb f1.txt - f2.txt
file1
STDIN
file2
```
