# Test-fluent
Test zig match 
Hello, you have a source called testfluent.zig that includes commonly used functions such as:

a) Text zone validity, e.g., "Pnom" where the first letter must be capitalized, etc. (OK)
b) Validity of characters (OK)
c) I haven't been able to create a customizable zone with 'comptime'

If you execute the source, you'll notice a number of functions that can't be performed. Among other things, during compilation, this causes errors indicating that I exceed the number of indices. For example, the date test is incorrect.

Otherwise, the project remains promising.


I forgot, in the source, you have functions using "pcre2posix.h" and functions that I tried to mimic for the same outcome.