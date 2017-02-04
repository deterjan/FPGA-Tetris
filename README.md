# FPGA-Tetris
Tetris implemented on BASYS 3 in SystemVerilog.

# Notes

* Before synthesis, create a clocking wizard named clk_wiz_0 using Vivado's Clocking Wizard IP.
Set out1 to 30 MHz, and out2 to 25.175MHz.

* Random number generation is done on an Arduino. Deploy the script int randomGen.txt on the Arduino and connect Arduino 
pins 11, 12, 13 to BASYS 3 pins  JA2, JA3, JA4.

* Blocks can be moved and rotated both by the buttons on BASYS 3 or from pins JC2, JC3, JC4, JC7.

* Connect two buzzers to pins JB1 and JC1 for music.

* gridCodeGen.txt contains a Java class that is used to generate code for the VGA module to display the game grid.

* Sometimes when multiple rows are supposed to be erased, one of them stays there, effectively breaking the game. This
bug arises possibly due to the significant setup time violation.

* There are slight visual glitches in the VGA image. However, they differ across builds so I couldn't identify the cause.
