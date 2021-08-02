#include<stdio.h>

int readInt() {
    int val;
    scanf("%d",&val);
    return val;
}

void printInt(int val, int endl) {
    if(endl) {
        printf("%d\n",val);
    } else {
        printf("%d ",val);
    }
}

int parmTest(int parm1, int parm2, int parm3, int parm4, int parm5, int parm6, int parm7, int parm8, int idx) {
    int num = -1;
    switch(idx) {
        case 1 : num = parm1; break;
        case 2 : num = parm2; break;
        case 3 : num = parm3; break;
        case 4 : num = parm4; break;
        case 5 : num = parm5; break;
        case 6 : num = parm6; break;
        case 7 : num = parm7; break;
        case 8 : num = parm8; break;
    }
    printInt(num, -1);
    return num;
}