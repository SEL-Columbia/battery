this repo is for dry-cell battery testing of batteries in developing
countries using simple microcontroller-based data acquisition.

a 10-bit ADC on an atmel 328 is used with the arduino environment.
ADC0 is connected directly to the battery output.  ADC1 is connected
to the high end of the shunt resistor to measure the battery current.

Current source

an opamp controlled constant current source is used to program output
current.  a voltage divider is used to set a bias voltage.  opamp feedback adjusts
the current source until the voltage across the shunt resistor
equals the voltage on the divider.  at 100 mA, the 1 ohm shunt resistor
has a voltage of 0.1V.  this means that the opamp must be able to
tolerate a voltage close to the zero rail.


i'm also experimenting with storing the data or results in a sqlite
database

LCD should update faster than sample output to file

microcontroller:
sippino was chosen for ease of breadboarding and access to AREF pin.

shunt resistor:
1 ohm

mosfet:
2N7000

opamp:
LM358

voltage reference:
10K resistor and zener reg 2.5V nominal


note:
plugging in serial pin of open log affects current reading on the
digital multimeter but not the LCD readout.  (this could be because the
change on the multimeter (3mA) is not within an LSB of the ADC.)
however, this shows that you need to separate digital and analog ground
since additional current is flowing through the battery circuit.