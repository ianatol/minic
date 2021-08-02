
; Sample LLVM file with read, while, print
;
; compile with: clang hello_world.ll helper.c

@.num = private unnamed_addr global i32 12

declare void @printInt(i32 nocapture) nounwind
declare i32 @readInt() nounwind

; Main
define i32 @main() { ; i32()*
    %count = call i32 @readInt()  ; Call 'read' helper routine
    call void @countdown(i32 %count)     ; Call function that loops
    ret i32 0                     ; Return
}


define void @countdown(i32 %parm) {
    store i32 %parm,i32* @.num  ; Load parm into a global
    br label %L1                ; Looks like EVERY label in LLVM has to be preceded by a branch. No fall-throughs
L1:                             ; While guard
    %v1 = load i32,i32* @.num   ; Load global into a register
    %bool = icmp eq i32 %v1,0   ; Check to see if it's zero
    br i1 %bool, label %L3, label %L2  ; If so, jump to the end. Otherwise, to next block
L2:
;    %v1 = load i32,i32* @.num
    call void @printInt(i32 %v1) ; Print the value
    %v2 = sub i32 %v1,1          ; Subtract 1
    store i32 %v2,i32* @.num     ; Store it in the global
;    %bool = icmp eq i32 %v2,0
    br label %L1                       ; Jump back up to guard
L3:
    ret void
}

