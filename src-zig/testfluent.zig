const std = @import("std");

// tools regex
const creg = @import("match");
// tools fluent regex
const freg = @import("fluent");

const allocatorPrint = std.heap.page_allocator;


pub const FREGEX = struct {
    width:	usize,
	scal:	usize,
	ncar:   usize,
    regex:  []const u8,	//contrôle regex 
};




fn isMatch(vbuf : [] const u8 , comptime  vmatch : [] const u8) bool {

      
     
    var rep = freg.match(vmatch,vbuf) ;

    while (rep.next()) |value| {
    const valx = std.fmt.allocPrint(allocatorPrint,"{s}",.{value}) catch unreachable;

    const val = std.mem.trim(u8,valx," \n");
    
    std.debug.print("Fluent Macth >{s}< : >{s}< \r\n",.{vbuf, val}) ;

    if ( std.mem.eql(u8, vbuf, val) ) return true else return false ;
    }

    return false;
}




fn testx( comptime w: usize ,  comptime s :usize, vbuf : [] const u8) void {

    const ncar :usize   = w + s ;    
    const regex = std.fmt.comptimePrint("^[A-Z]{s}1{s}[a-zA-Z0-9]{s}1,{d}{s}", .{"{", "}",  "{", ncar, "}" });      
    std.debug.print("fluent:{s} \r\n",.{vbuf});
    std.debug.print("fluent:{s} \r\n",.{regex});
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{vbuf,isMatch(vbuf,regex  )});
}


 fn RtnReg( comptime w: usize ,  comptime s :usize) [] const u8 {

    const ncar :usize   = w + s ;    
    return std.fmt.comptimePrint("^[A-Z]{s}1{s}[a-zA-Z0-9]{s}1,{d}{s}", .{"{", "}",  "{", ncar, "}" }); 


}


 
pub fn main() !void {

// ====================================================================================================
    // not parametrable model ex import json or fonction 
    // This implies: that the parameters are fixed values known before compilation  (ex : 5 and 1)
    testx(5,1,"Pabcex");

    // const xreg = std.fmt.allocPrint(allocatorPrint,"{s}",.{"^[A-Z]{1}[a-zA-Z0-9]+"}) catch unreachable;
    // error
    // const ztest = std.fmt.comptimePrint("{s}", .{xreg});
    
    // testx(5,1,"Pabcex");
    // RtnReg(5,1) ;
    std.debug.print("fluent:{s} ismatch:{} \r\n",.{"Pabcex",isMatch("Pabcex",RtnReg(5,1))});
   
}
