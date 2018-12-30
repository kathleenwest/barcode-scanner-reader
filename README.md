# barcode-scanner-reader

Raising the Bar -A Barcode Scanner


An undergraduate team project in microprocessor applications. 


Project Blog Site is here: https://portfolio.katiegirl.net/2018/12/30/raising-the-bar-a-barcode-scanner/


Executive Summary

In our daily lives we often encounter barcode scanners, usually, in the check-out lines in supermarkets and in retail stores, this project is a basic barcode scanner which uses a regular white 8 ½ by 11-inch sheet of paper for the barcode and a generic infrared transmitter and receiver for scanning. The infrared transmitter used for this project is not by any means spectacular or powerful and it may be found in a college student’s lab kit. When D.C. current is supplied to the transmitter, it emits a narrow beam of infrared light, which is invisible to the human eye. The infrared receiver used in this project, just as the transmitter, is simple as well. When this receiver, which acts as a variable resistor, detects infrared light, its resistance increases. This results in an increase in the percentage of the 5V that it takes up. That means an increase in the voltage difference. This is noticeable when combined with a large enough resistor.

When the barcode is scanned for its binary code, the transmitter shines an infrared light beam onto the surface of the barcode; the white surface reflects the infrared beam off of itself, while the black surface absorbs a substantial amount of the infrared beam. Thus, the infrared receiver, which is effectively angled for best results, will detect the reflected light from the white surfaces, but it will not detect a significant amount of reflected light from the black surfaces. The reading of the barcode is simply a reading of the voltage drops that happen or do not happen to the infrared receiver as a result of it receiving or not receiving reflected light. The barcodes used in this project are divided into eight sections, where each section corresponds to a “bit” of an eight-bit binary number. When the receiver does not detect infrared light during one of its eight scanning phases, it is recorded as logical ‘1’ and detected infrared light is recorded as logical ‘0’.
The heart of the entire system is the Motorola HC11 microprocessor. It coordinates the following: storage of received data, processing of received data, the operation of the print feeder, and screen output. All of the programming in assembly language makes the hardware setup much simpler than it really should be. Bringing all of this together is the HC11 as it tells one their fortune by the barcode that describes them. Where will you live in the future?

