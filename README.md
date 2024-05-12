# Test-fluent
Test zig match 
Hello, you have a source called testfluent.zig that includes commonly used functions such as:

a) Text zone validity, e.g., "Pnom" where the first letter must be capitalized, etc. (OK)
b) Validity of characters (OK)
c) I haven't been able to create a customizable zone with 'comptime'

If you execute the source, you'll notice a number of functions that can't be performed. Among other things, during compilation, this causes errors indicating that I exceed the number of indices. For example, the date test is incorrect.

Otherwise, the project remains promising.


I forgot, in the source, you have functions using "pcre2posix.h" and functions that I tried to mimic for the same outcome.



manjro pacman -S pcre2 version 10-42-2

https://www.pcre.org/

https://github.com/PCRE2Project/pcre2

he pcre lib is deprecated
the pcre2 lib is valid and as indicated in the isMatch source, you must put the extended function

the source compares the use of libepcre2 (regex) and the fluent.zig process

Tests with fluent only work with comptime,
so you cannot have a function with variables and configure the regex rule, I commented out the inoperative functions in the source file, it's a shame not to be able to construct a comptime variable with anything other than fixed constants .
My current experience forces me to keep the libpcre2 process in C language