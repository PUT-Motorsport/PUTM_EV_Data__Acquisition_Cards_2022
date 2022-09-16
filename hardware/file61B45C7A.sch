EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 23
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L AT24CSW020-STUM-T:M24C01-WMN U4
U 1 1 61B9A311
P 5750 2950
F 0 "U4" H 5750 3431 50  0000 C CNN
F 1 "M24C01-WMN" H 5750 3340 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5750 3300 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/b0/d8/50/40/5a/85/49/6f/DM00071904.pdf/files/DM00071904.pdf/jcr:content/translations/en.DM00071904.pdf" H 5800 2450 50  0001 C CNN
	1    5750 2950
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR023
U 1 1 61B9A9EF
P 4150 1950
F 0 "#PWR023" H 4150 1800 50  0001 C CNN
F 1 "+3.3V" H 4165 2123 50  0000 C CNN
F 2 "" H 4150 1950 50  0001 C CNN
F 3 "" H 4150 1950 50  0001 C CNN
	1    4150 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR024
U 1 1 61B9CBFB
P 4150 2700
F 0 "#PWR024" H 4150 2450 50  0001 C CNN
F 1 "GND" H 4155 2527 50  0000 C CNN
F 2 "" H 4150 2700 50  0001 C CNN
F 3 "" H 4150 2700 50  0001 C CNN
	1    4150 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 2700 4150 2650
Wire Wire Line
	6150 2850 6650 2850
Wire Wire Line
	6150 2950 6300 2950
$Comp
L Device:R R9
U 1 1 61B9D782
P 6300 2300
F 0 "R9" H 6370 2346 50  0000 L CNN
F 1 "4.7k" H 6370 2255 50  0000 L CNN
F 2 "" V 6230 2300 50  0001 C CNN
F 3 "~" H 6300 2300 50  0001 C CNN
	1    6300 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 61B9E032
P 6650 2300
F 0 "R10" H 6720 2346 50  0000 L CNN
F 1 "4.7k" H 6720 2255 50  0000 L CNN
F 2 "" V 6580 2300 50  0001 C CNN
F 3 "~" H 6650 2300 50  0001 C CNN
	1    6650 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2450 6300 2950
Connection ~ 6300 2950
Wire Wire Line
	6300 2950 6750 2950
Wire Wire Line
	6650 2450 6650 2850
Connection ~ 6650 2850
Wire Wire Line
	6650 2850 6750 2850
$Comp
L power:+3.3V #PWR026
U 1 1 61BA0103
P 6450 2000
F 0 "#PWR026" H 6450 1850 50  0001 C CNN
F 1 "+3.3V" H 6465 2173 50  0000 C CNN
F 2 "" H 6450 2000 50  0001 C CNN
F 3 "" H 6450 2000 50  0001 C CNN
	1    6450 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 2000 6450 2050
Wire Wire Line
	6450 2050 6300 2050
Wire Wire Line
	6300 2050 6300 2150
Wire Wire Line
	6450 2050 6650 2050
Wire Wire Line
	6650 2050 6650 2150
Connection ~ 6450 2050
Text HLabel 6750 2850 2    50   BiDi ~ 0
SDA
Text HLabel 6750 2950 2    50   BiDi ~ 0
SCL
$Comp
L power:GND #PWR025
U 1 1 61BA1A12
P 5750 3300
F 0 "#PWR025" H 5750 3050 50  0001 C CNN
F 1 "GND" H 5755 3127 50  0000 C CNN
F 2 "" H 5750 3300 50  0001 C CNN
F 3 "" H 5750 3300 50  0001 C CNN
	1    5750 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 3300 5750 3250
$Comp
L Device:C C19
U 1 1 61BBFFFD
P 4150 2500
F 0 "C19" H 4265 2546 50  0000 L CNN
F 1 "100nF" H 4265 2455 50  0000 L CNN
F 2 "" H 4188 2350 50  0001 C CNN
F 3 "~" H 4150 2500 50  0001 C CNN
	1    4150 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:Ferrite_Bead FB5
U 1 1 61BC287E
P 4150 2150
F 0 "FB5" H 4287 2196 50  0000 L CNN
F 1 "Ferrite_Bead" H 4287 2105 50  0000 L CNN
F 2 "" V 4080 2150 50  0001 C CNN
F 3 "~" H 4150 2150 50  0001 C CNN
	1    4150 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 1950 4150 2000
Wire Wire Line
	4150 2300 4150 2350
Connection ~ 4150 2350
Text Label 3250 2350 0    79   ~ 0
3.3V_EEPROM
Wire Wire Line
	3250 2350 4150 2350
Wire Wire Line
	5750 2650 5750 2250
Text Label 5750 2250 1    79   ~ 0
3.3V_EEPROM
$EndSCHEMATC