#include<stdio.h>
#include<stdlib.h>
struct EV_Power
{
int EV_base;
int EV_exp;
};
int _calcPower(int EV_base,int EV_exp)
{
int EV_result;
EV_result = 1;
while ((EV_exp>0))
{
EV_result = (EV_result*EV_base);
EV_exp = (EV_exp-1);
}
return EV_result;
}
int _main()
{
struct EV_Power * EV_power;
int EV_input;
int EV_result;
int EV_exp;
int EV_i;
EV_power = (struct EV_Power*)malloc(sizeof(struct EV_Power));
EV_result = 0;
scanf("%d", &EV_input);
EV_power->EV_base = EV_input;
scanf("%d", &EV_input);
if ((EV_input<0))
{
return (-1);
}
EV_power->EV_exp = EV_input;
EV_i = 0;
while ((EV_i<1000000))
{
EV_i = (EV_i+1);
EV_result = _calcPower(EV_power->EV_base, EV_power->EV_exp);
}
printf("%d\n", EV_result);
return 1;
}
int main(void)
{
   return _main();
}

