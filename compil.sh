#!/bin/sh
( set -x ; \
zig build -Doptimize=Debug --build-file $HOME/Zfluent/src-zig/buildtestfluent.zig;\
)



	if test -f "$HOME/Zfluent/src-zig/zig-out/bin/testfluent" ; then
		echo -en " testfluent  size : "
		ls -lrtsh $HOME/Zfluent/src-zig/zig-out/bin/testfluent | cut -d " " -f6
		
		mv  $HOME/Zfluent/src-zig/zig-out/bin/testfluent $HOME/Zfluent/testfluent
	fi

rm -r $HOME/Zfluent/src-zig/zig-cache

rm -r $HOME/Zfluent/src-zig/zig-out
exit