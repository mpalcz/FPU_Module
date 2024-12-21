OVERVIEW
The primary goal of this project is to design the four most commonly used floating-point operations from scratch; namely addition, subtraction, multiplication, and division; 
in order to gain a deeper understanding of the complexities and functionality of one of the essential components of a modern CPU: the FPU. To be able to design arithmetic 
operations for floating point values, we considered the data paths of the three bit fields of single-precision IEEE 754 Standard separately and used both extensive critical 
thinking and our background knowledge in Digital Systems I and Computer Architecture I to develop working schematics for such a hardware. For multiplication and division, the 
designs are analogous with the difference being primarily the main component that performs multiplication and that which performs division between the fractional fields. Addition 
and subtraction also resulted in similar implementations, yet required more notable differences, including the order of the operands into the Adder/Subtractor, control signals 
for the multiplexers directing the flow of data, and the sign of the result. Following each arithmetic operation, the resulting floating-point value must be normalized. As such, 
we designed a universal normalizer which shifts the fractional field until the first 1 is pushed off (i.e. hiding the implicit 1 of the mantissa), and adjusts the exponent field 
according to the number of shifts. This is explained in further detail later in the report. The following four sections (Multiplication, Division, Addition, Subtraction) describe 
the logic of the constructed circuits and show the final design of each operation.

MULTIPLICATION
The following explains how each bit field of the result was determined. 
Sign: In order to determine the sign of the result, the two sign bits of the inputs (X31 and Y31) are passed through a xor gate, due to the fact that when two numbers have the 
same sign the result is positive, and when they have opposite signs, it is negative in multiplication. 
Exponent: For regular multiplication, the two exponents are added to give the resultant exponent. The main idea is the same in floating point arithmetic, but it is nuanced by 
the bias. Since two biased exponents are added, there is an extra 127 being counted. Thus, the final design of the multiplication circuit includes 1) the exponents being added 
using an adder/subtractor (with control input 0) and 2) 127 being subtracted from the resultant exponent by passing through a second adder/subtractor (with control input 1). If 
the exponent cannot fit within the range of 0 to 255 (equivalent to -127 to 128 in actual value) then the overflow detection will output a 1.
Fraction: To determine the value of the resultant fraction field, the two fraction fields are passed through a multiplier that is explained in detail further in our report. The 
multiplier is 24x24 bits to allow for the hidden bits to be accounted in the multiplication operation.
Finally, before the exponent and fraction are outputted, they pass through the normalizer to be stored according to the IEEE 754 Standard.

DIVISION
Explained below is how we determined each bit field of the result of our division operation.
Sign: The sign is determined the same way as it was for multiplication since the same rules apply (the two sign bits of the inputs are passed through a xor gate and the result is 
the sign of the quotient). 
Exponent: For division, it is necessary to subtract the exponents of the inputs to compute the exponent of the result. This is accomplished by subtracting the exponent of the dividend 
by that of the divisor with an adder/subtractor (Control = 1). Due to the nature of how exponents are stored (biased), when performing this subtraction, the result is the non-biased 
exponent of the result. As such, we added 127 to the exponent using another adder/subtractor (Control = 0). If the exponent cannot fit within the range of 0 to 255 (equivalent to -127 
to 128 in actual value) then the underflow detection will output a 1.
Fraction: In order to determine the resultant fraction field, the two fractions are passed through a divider. This 24x24 bit divider is explained in more detail further in this report. 
The hidden bit of each operand is also involved at this stage, similar to what we did for multiplication. 
Once the exponent and fraction are normalized with help of the normalizer, the operation is complete. 

ADDITION
The implementation of addition was more complex than for multiplication and division. This is mostly due to the fact that the operation performed depends on the sign of the operands 
and one of the values may be required to shift to match exponents with the larger. 
Sign: The sign of the sum is determined by considering a few factors. We knew that if both numbers were positive, the result would be positive. If one number was negative, depending 
on which is larger, the result could either be positive or negative. Furthermore, if they were both negative, the result would be definitively negative. We designed our circuit in such a 
way that if both operands were negative, addition is performed and we would consider the sign separately. So, the result is negative in two cases, a) the two operands are negative (i.e. X31 ∧ Y31) 
OR b) the result straight from the adder/subtractor is negative (S23 = 1). 
Exponent: The resultant exponent in an addition operation, before normalization, will be equivalent to the larger exponent of the two operands, since we shift both operands to match this magnitude. 
To compare, we passed the exponents through a subtractor. The larger exponent is passed through to the normalizer with multiplexers, whose selection lines depend on the sign of the difference as well 
as whether the difference was zero or not
Fraction: To determine the resultant fraction, there are many steps to follow before performing the actual addition. First, the two exponents must be subtracted to reveal which is larger. This is done 
by performing the following with the adder/subtractor: Xexponent - Yexponent. If the result is negative, then the fraction of X must be shifted to the right by the two’s complement of the result. If 
the result is positive, Y must be shifted to the right the as many times as indicated by the result. To perform shifts a variable number of times, we designed a variable shifter which is explained later 
in the report. With the use of many multiplexers and a demultiplexer to disable or enable variable shifters, we choose which “version” of the operand must be used (shifted or not) and in which order they 
should enter the 24-bit adder/subtractor. The order must be switched only if the first operand is negative and the second is positive. This is because the adder/subtractor’s control signal is dictated by 
whether exactly one of the values is negative. Thus, the operands must be switched to perform Y - X in twos complement subtraction. Since it is possible for the value of the sum to come out negative, we 
have a two’s complementer that takes the two’s complement of the result only if the MSB is 1. This way, we can ensure that the result is still stored in signed magnitude format, noting the resultant sign 
for the sign bit as discussed previously. 
Finally, the exponent and the fraction are sent to the normalizer and are stored in IEEE 754 Standard.

SUBTRACTION
The implementation of subtraction was very analogous to that of addition with a few notable differences, including the logic gates required to determine the sign bit and further consideration of the order 
of the operands in the Adder/Subtractor and the corresponding control signal for the proper operation

Sign: To determine the sign, all factors discussed in addition are the same. However, since the order of operands might differ depending not only on the signs of each operand, but which operand follows 
the minus, being that the minus sign in subtraction (X - Y) changes the sign of the second operand. This nuance was considered in such a way that in the case that both operands were negative (i.e. -X - (-Y)), 
the order of the operands would switch to have Y + [X] in the Adder/Subtractor. All cases of the signs of each operand and the sign of the Adder/Subtractor result were considered in a Karnaugh map to derive a 
simplified boolean expression for the sign bit: AB’ + S23
Exponent: Like addition, the exponent in a subtraction operation before normalization, will be equivalent to the larger exponent of the two operands, since we shift both operands to match this magnitude. With 
the use of multiplexers and the subtraction operation on the exponents to determine which, if any, is the larger, the larger exponent is pipelined to the normalizer.
Fraction: At this stage, every step described in addition for the fractional bit field is the same as for subtraction, with a difference in the control signal for the operation of the Adder/Subtractor

MAJOR SUBCOMPONENTS

1. NORMALIZER
For the normalizer, the goal was to design a component that would shift the fraction and increment the exponent simultaneously until the first 1 of the fraction was shifted off (hiding the implicit 1 for the
final result). 
First, we have a 48-bit parallel in, serial out register that initially is loaded with the resultant fraction from whatever operation was performed (Sel = 1). It is 48 bits wide due to the multiplication
resulting in the largest result (24x24 = 48 bits). For all the other operations, the fraction remained 24 bits, in which case we simply made the least significant 24 bits 0. At every clock cycle, one bit
is shifted off this register at a time (starting from the most significant bit, since it is shift left). This bit is sent as the input of a D flip-flop whose output determines whether the exponent must be
incremented.
The exponent incrementing part of the circuit is on the right side of the diagram. Here, we have an 8-bit adder/subtractor made of HAs and an 8-bit register which stores the exponent and restores it after
every increment. What controls whether the exponent is increased or not is the bit shifted off the fraction. If the bit shifted off is 0, it is inverted and 1 is added to the exponent. If it is 1, then 0 is
added to the exponent. Thus, the exponent is increased until the point where the first 1 (which must be made implicit further on) is reached. 
Once the first 1 is outputted from the input fraction shift register, the output from the D flip flop it is attached to will always be 1 (since the input is or’d with the previous output). This enables a
mod24 counter which itself enables the output fraction shift register. Since the bit shifted off the fraction is sent as the input of the output shift register, at every clock cycle one bit is inserted to
the output fraction, until the counter reaches its final state (24). The output shift register is only 23 bits wide, but we must continue shifting until we count 24 in order to shift off the hidden bit. 
This component was used as the final step for each of our arithmetic operations, so it was crucial that it functioned. In the next slides we show the diagram of our normalizer and a simulation run which
verified its functionality. 

2. MULTIPLIER
This component performs the actual multiplication required between the input fractions in the Multiplication circuit. It contains three registers; one 48-bit parallel in, parallel out (PIPO) left shift register
(multiplicand), a 48-bit PIPO register (product), and a 24-bit parallel in, serial out (PISO) right shift register (multiplier). 
The multiplicand is stored in the right half of the register and shifted to the left at every clock cycle. It then is added together with either the product (initially 0) or does not change; in each clock cycle,
the product is either added with the multiplicand or added with all 0s. The bit that is shifted off the multiplier at a given clock cycle is used as a select line for this multiplexer that chooses to either add
0 (nothing) to the multiplicand or to add the product. In this manner, the multiplication of two fractions continues until the multiplier consists of only 0s, which is flagged by checking all multiplier bits
with a nor gate. 

3. DIVIDER
This component performs the division required between the two input fractions in the Division circuit. It contains three registers; a 48-bit PIPO shift right register (divisor), a 48-bit PIPO register (remainder),
and a serial in, 23-bit shift left register (with a 24th bit stored in a D flip-flop outside of the shift register). 
The algorithm for division was slightly more complex than multiplication because the operation performed by the adder/subtractor depended on the result stored in the remainder. Thus, the MSB bit of the
remainder is used to control the enables of all the registers and the control signal of the adder/subtractor (if it is 1, then perform addition between the divisor and the remainder, else perform subtraction). 
We further considered that for every clock cycle, we wanted to shift the quotient first (from the previous division) and then insert the next bit (which is 1 if the remainder is positive, and 0 if it is negative). To do this, we kept bit0 of the quotient in a D flip-flop separate from the register, so there is a slight delay.

4. VARIABLE SHIFTER
The variable shifter was designed to shift a value a variable number of times (not predetermined). For our purposes, we only used it in the context of shifting a number to the right (used in Addition
to shift the smaller fraction to the right to match its exponent to the larger one). Initially, there is an input shift amount that is selected from multiplexers (shift amount is 8 bits, so 8 multiplexers).
This is then stored in an 8-bit PIPO register. Next, the values are decremented by 1 and the input fraction is subsequently shifted once to the right using a 24-bit PIPO shift right register. This
continues until the value of the shift amount is decremented to 0, at which point all components are disabled and the number has been shifted the correct number of times. 
