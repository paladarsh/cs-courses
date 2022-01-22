#include <stdio.h>
#include <math.h>

int main (void)
{
	// Examples to demonstrate default rounding mode (round to nearest and round to even nearest if halfway)

	//float x = 2 - pow(2, -24); // 1.1111...11 (mantissa has 24 1s)
	float x = 2 - 3*pow(2, -24); // 1.1111...01 (mantissa has 22 1s followed by one 0, and then one 1)

	unsigned int sbit;
	unsigned int exponent;
	unsigned int fraction;
	sbit = ((*((unsigned int*)&x)) >> 31) & 1;
	exponent = ((*((unsigned int*)&x)) >> 23) & 0xff;
	fraction = (*((unsigned int*)&x)) & 0x7fffff;
	printf("Float value: %.30f, sign bit: %u, biased exponent: %u, actual exponent: %d, mantissa: %#x\n", x, sbit, exponent, exponent-127, fraction); 
	return 0;
}
