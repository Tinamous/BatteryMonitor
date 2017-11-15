Internet Of Things Remote System Monitor
========================================

For remote locations a battery powered devices may be the only realistic way of powering equipment, these may be left to work for months or years until one day the battery dies or goes flat unexpectedly or something else happens.

This project uses the Sigfox Arduino MKR FOX 1200 to provide low power wireless internet connectivity and a INA219 to monitor the battery. This allows monitor and early notification of problems.

Additionally 2x latching relays, 3x N-Channel fets and some digital/analog inputs provide means to monitor other parts of a system as well (e.g. monitor switches, water levels, control pumps, lights etc.).

The system is composed of:

* Arduino MKR FOX 1200 Sigfox based Arduino.
* INA219 power monitor (0R1 resistor - limited to 2A due to package size).
* 2x Latching relays for output and charger input.
* 3x N-Channel FET outputs.
* 6x Analog input connectors (4x 3 pin with GND, 3v3 and signal, 1x 4 pin with GND 5V and 2x signal divided to allow 5V analog).
* On-board 5V buck regulator from the battery.
* On-board 3v3 regulator for relay and analog connectors.
* Mini prototyping area.
* Always on USB A power output.


Primary Use Case - Garage
=========================

* 12V Lead Acid Battery (i.e. car battery) connected to the battery input
* Powered system connected to the output (humidity controlled boxes).
* Solar charger connected to charger connector.
* LED lighting connected to FET1, 2 and 3.

Alternative Usages:
* The battery connector can be used as an output with inputs from 2 batteries or a power supply and battery allowing a backup power source to be switched in should the primary fall out of acceptable range. In this case the power measurement is purely for output and does not include power used through the FET outputs, analog inputs or the system itself.
