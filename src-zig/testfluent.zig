const std = @import("std");

// tools regex
const creg = @import("match");
// tools fluent regex
const freg = @import("fluent");

const allocatorPrint = std.heap.page_allocator;

fn isMatch(vbuf : [] const u8 , comptime  vmatch : [] const u8) bool {

      
     
    var rep = freg.match(vmatch,vbuf) ;

    while (rep.next()) |value| {

    // std.debug.print("Fluent Macth {s}: {s} \r\n",.{vbuf, value}) ;

    if ( std.mem.eql(u8, vbuf, value) ) return true else return false ;
    }

    return false;
}

pub const FREGEX = struct {
    width:	usize,
	scal:	usize,
	ncar:   usize,
    regex:  []const u8,	//contrôle regex 
};


fn testx( comptime w: usize ,  comptime s :usize,vbuf : [] const u8) void {
    comptime var f : FREGEX = undefined;
    f.width = w;
    f.scal = s;
    
    f.ncar  = w + s ;
    
    f.regex = std.fmt.comptimePrint("^[A-Z]{{1}}[a-zA-Z0-9]{s}1,{d}{s}", .{"{", f.ncar,"}" });
      
    std.debug.print("fluent:{s} \r\n",.{f.regex});
    std.debug.print("fluent:{s} {} \r\n",.{vbuf,isMatch(vbuf,f.regex  )});

}

 
pub fn main() !void {

// ====================================================================================================
    // not parametrable model ex import json or fonction 
    // This implies: that the parameters are fixed values known before compilation  (ex : 5 and 1)
    testx(5,1,"Pabcex");

    // const xreg = std.fmt.allocPrint(allocatorPrint,"{s}",.{"^[A-Z]{1}[a-zA-Z0-9]+"}) catch unreachable;
    // error
    // const ztest = std.fmt.comptimePrint("{s}", .{xreg});
    
    const ztest = std.fmt.comptimePrint("{s}", .{"^[A-Z]{1}[a-zA-Z0-9]+"});
    std.debug.print("fluent:{s} {} \r\n",.{"Pabcex12345azertyuiop",isMatch("Pabcex12345azertyuiop",ztest)});
// ====================================================================================================

    std.debug.print("-----------------------\r\n",.{});
    var buf  : [] const u8 = "P1";
    // contrôl "P1"
    std.debug.print("Macth {s}: {} \r\n",.{buf,creg.isMatch(buf,"^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
    
    std.debug.print("fluent {s} :{} \r\n",.{buf,
        isMatch(buf,"^[A-Z]{1}[a-zA-Z0-9]")});
 
    
    
    std.debug.print("-----------------------\r\n",.{});
    buf =undefined;
    buf = "p1";
    // contrôl "P1"
    std.debug.print("Macth {s}: {} \r\n",.{buf,creg.isMatch(buf,"^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;

    std.debug.print("fluent {s} :{} \r\n",.{buf,
        isMatch(buf,"[A-Z]{1}[a-zA-Z0-9]{1,2}") });
    
    
    std.debug.print("-----------------------\r\n",.{});
    buf =undefined;
    buf = "P";
    // contrôl obligatoire P and 1
    std.debug.print("Macth {s}: {} \r\n",.{buf,creg.isMatch(buf,"^[A-Z]{1,1}[a-zA-Z0-9]{1,}$")}) ;

    std.debug.print("fluent {s} :{} \r\n",.{buf,
        isMatch(buf,"[A-Z]{1}[a-zA-Z0-9]{1,2}")
         });
     
    
    std.debug.print("-----------------------\r\n",.{});
    buf =undefined;
    buf = "P1abc";
    std.debug.print("Macth {s}: {} \r\n",.{buf,creg.isMatch(buf,"^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
    // Attenion length
    std.debug.print("fluent {s} :{} \r\n",.{buf,
        isMatch(buf,"[A-Z]{1}[a-zA-Z0-9]{1,5}")
        });

    // not accept var 
    const widthx = 3;
    const scalx  = 2;
    
    const number: usize = widthx + scalx;
    const string: []const u8 = std.fmt.comptimePrint("[A-Z]{1}[a-zA-Z0-9]{s}1,{d}{s}", .{"{", number,"}" });
    std.debug.print("fluent:{} \r\n",.{isMatch(buf, string)});
     
    std.debug.print("-----------------------\r\n",.{});
    buf =undefined;
    buf = "P1@";
    // improper
    std.debug.print("Macth {s}: {} \r\n",.{buf,creg.isMatch(buf,"^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
    std.debug.print("fluent {s} :{} \r\n",.{buf,
        isMatch(buf,"[A-Z]{1}[a-zA-Z0-9]{1,3}") 
    });
  
    std.debug.print("-----------------------\r\n",.{});
    buf =undefined;
    buf = "@P1";
    // improper
    std.debug.print("Macth {s}: {} \r\n",.{buf,creg.isMatch(buf,"^[A-Z]{1,1}[a-zA-Z0-9]{0,}$")}) ;
    std.debug.print("fluent {s} :{} \r\n",.{buf,
        isMatch(buf,"[A-Z]{1}[a-zA-Z0-9]{1,3}") 
    });
        
    std.debug.print("-----------------------\r\n",.{});
    buf =undefined;
    buf = "1951-02-29";
   
    // test date réel contrôl full
    std.debug.print("Macth {s} date iso{} \r\n",.{buf,creg.isMatch(
    buf,
    "^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$")});

    std.debug.print("fluent {s} date iso:{} \r\n",.{buf,
          isMatch(buf,"^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$")
     });     


    buf =undefined;
    buf = "1952-02-29";
    std.debug.print("Macth {s} date iso{} \r\n",.{buf,creg.isMatch(
    buf,
    "^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$")});

    std.debug.print("fluent {s} :{} \r\n",.{buf,
          isMatch(buf,"^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$")
     });                                                            // gets lost in this clues |[3][0-1]{1,2}



         
    //oreilly editor book
    buf =undefined;
    buf = "jpl-myname.myfirstname@gmail.com";
    std.debug.print("Macth {s} mail: {} \r\n",.{buf,creg.isMatch(
    buf,
    "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@([a-zA-Z0-9.-])+$")});

    std.debug.print("fluent {s} mail :{} \r\n",.{buf,
         isMatch(buf,"[a-zA-Z0-9_!#$%&.-]+@([a-zA-Z0-9.-])+")
    });


    const width :usize = 5;
    const scal :usize = 2;
    buf =undefined;
    buf = "12345.02";
    // decimal unsigned  scal > 0
    std.debug.print("Macth decimal unsigned {s} scal > 0 {} \r\n",.{buf,creg.isMatch(
    buf,
    std.fmt.allocPrint(allocatorPrint,
    "^[0-9]{s}1,{d}{s}[.][0-9]{s}{d}{s}$",.{"{",width,"}","{",scal,"}"}
    ) catch unreachable)});

    std.debug.print("fluent {s} :{} \r\n",.{buf,
         isMatch(buf,"^[0-9]{1,5}[.][0-9]{2}$")
    });

    const xtestnum = std.fmt.comptimePrint( "^[0-9]{s}1,{d}{s}[.][0-9]{s}{d}{s}$",.{"{",width,"}","{",scal,"}"});
      
    std.debug.print("fluent:{s} \r\n",.{ xtestnum});
    std.debug.print("fluent:{s} {} \r\n",.{buf,isMatch(buf, xtestnum  )});
         
}

