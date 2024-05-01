const std = @import("std");

// tools regex
const creg = @import("match");
// tools fluent regex
const freg = @import("fluent");

const allocatorPrint = std.heap.page_allocator;

fn isMatch(vbuf : [] const u8 ,  comptime vmatch : [] const u8) bool {
    
    var rep = freg.match(vmatch,vbuf) ;

    while (rep.next()) |value| {

    std.debug.print("Fluent Macth {s}: {s} \r\n",.{vbuf, value}) ;

    if ( std.mem.eql(u8, vbuf, value) ) return true else return false ;
    }

    return false;
}


pub fn main() !void {




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
    // const allocRegex = std.heap.page_allocator;
    // const xx = std.fmt.allocPrint(allocRegex,"[A-Z]{1}[a-zA-Z0-9]{{1,{d}}}",.{buf.len}) catch unreachable;
    // std.debug.print("fluent:{} \r\n",.{isMatch(buf,xx)});
    
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
    
    // test unconventionnal date improper
    
    std.debug.print("Macth {s} date iso{} \r\n",.{buf,creg.isMatch(
    buf,
    "^([0-9]{4,4})[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$")});

    // test date réel contrôl full
    std.debug.print("Macth {s} date iso{} \r\n",.{buf,creg.isMatch(
    buf,
    "^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$")});

    buf =undefined;
    buf = "1952-02-29";
    std.debug.print("Macth {s} date iso{} \r\n",.{buf,creg.isMatch(
    buf,
    "^([0-9]{4}[-/]?((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))|([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00)[-/]?02[-/]?29)$")});


// scratch compile 
    // buf = "1951-11-30";
    // std.debug.print("fluent {s} :{} \r\n",.{buf,
    //      isMatch(buf,"([0-9]{4})[-](0[1-9]|1[012])[-]([0-2][0-9]{1,2}|[3][0-1]{1,2})")
    // });                                                            // gets lost in this clues |[3][0-1]{1,2}

    buf =undefined;
    buf = "1951-02-29";
    std.debug.print("fluent {s} :{} \r\n",.{buf,
         isMatch(buf,"([0-9]{4})[-](0[1-9]|1[012])[-]([0-2][0-9]{1,2})")
    });

    // only 02-28
    buf =undefined;
    buf = "1951-02-29";
    std.debug.print("fluent hard test 28 {s} :{} \r\n",.{buf,
         isMatch(buf,"([0-9]{4})[-](0[1-9]|1[02])[-]([2][8]{1,2})")
    });


    // test digit date improper
    buf =undefined;
    buf = "1951-11-30";
    std.debug.print("fluent {s} :{} \r\n",.{buf,
         isMatch(buf,"([0-9]{4})[-](0[1-9]|1[012])[-]([0-3][0-9]{1,2})")
    });


 // https://stackoverflow.com/questions/201323/how-can-i-validate-an-email-address-using-a-regular-expression
  // chapitre RFC 6532 updates 5322 to allow and include full, clean UTF-8.

      std.debug.print("Macth Mail{} \r\n",.{creg.isMatch(
      "myname.myfirstname@gmail.com",
      "^([-!#-\'*+\\/-9=?A-Z^-~]{1,64}(\\.[-!#-\'*+\\/-9=?A-Z^-~]{1,64})*|\"([]!#-[^-~ \t]|(\\[\t -~]))+\")@[0-9A-Za-z]([0-9A-Za-z-]{0,61}[0-9A-Za-z])?(\\.[0-9A-Za-z]([0-9A-Za-z-]{0,61}[0-9A-Za-z])?)+$")});

    //oreilly editor book
    buf =undefined;
    buf = "myname.myfirstname@gmail.com";
    std.debug.print("Macth Mail{} \r\n",.{creg.isMatch(
    "myname.myfirstname@gmail.com",
    "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")});

    std.debug.print("fluent {s} :{} \r\n",.{buf,
         isMatch(buf,"[a-zA-Z0-9_!#$%&.-]+@[a-zA-Z0-9.-]+")
    });

    const width :usize = 5;
    const scal :usize = 2;
    buf =undefined;
    buf = "12345.02";
    // decimal unsigned  scal > 0
    std.debug.print("Macth decimal unsigned  scal > 0 {} \r\n",.{creg.isMatch(
    buf,
    std.fmt.allocPrint(allocatorPrint,
    "^[0-9]{s}1,{d}{s}[.][0-9]{s}{d}{s}$",.{"{",width,"}","{",scal,"}"}
    ) catch unreachable)});

    std.debug.print("fluent {s} :{} \r\n",.{buf,
         isMatch(buf,"[0-9]{1,5}[.][0-9]{1,2}")
    });
}
