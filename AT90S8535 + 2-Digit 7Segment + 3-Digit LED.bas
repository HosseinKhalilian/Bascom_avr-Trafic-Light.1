'======================================================================='

' Title: 7seg Trafic Light
' Last Updated :  03.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : AT90S8535 + 2-Digit 7Segment + 3-Digit LED

'======================================================================
$regfile = "8535def.dat"
$crystal = 1000000

Config Porta = Output
Config Pina.0 = Input
Config Pina.1 = Input
Config Portb = Output
Config Portc = Output
Config Portd = Output


Dim A As Byte
Dim B As Byte
Dim C As Byte
Dim M As Byte
Dim H As Byte

M = 15
Main:
Set Porta.2
Set Porta.3

'-----------------------------------------------------------

Do
Portb = 33
Reset Porta.2
Gosub Sub1
Portb = 34
Wait 3
Set Porta.2
Portb = 12
Reset Porta.3
Gosub Sub1
Portb = 20
Wait 3
Set Porta.3
Loop
End

'-----------------------------------------------------------

Sub1:
A = M
Do
If Pina.0 = 1 Then Gosub Inc
If Pina.1 = 1 Then Gosub Dec
Gosub Sub2
Wait 1
If A = 0 Then Exit Do
Decr A
Loop
Return


''''''''''''''''''''''''''''''

Sub2:
B = A / 10
C = B * 10
C = A - C
Portd = Lookup(b , Dta)
Portc = Lookup(c , Dta)
Return


''''''''''''''''''''''''''''''

Dta:
Data 63 , 6 , 91 , 79 , 102 , 109 , 125 , 7 , 127 , 111


''''''''''''''''''''''''''''''

Inc:
Reset Porta.2
Reset Porta.3
Do
Incr M
If M = 100 Then M = 5
A = M
Gosub Sub2
If Pina.0 = 0 Then Goto 7
Waitms 500
Loop
Return


''''''''''''''''''''''''''''''

Dec:
Reset Porta.2
Reset Porta.3
Do
Decr M
If M = 4 Then M = 99
A = M
Gosub Sub2
If Pina.1 = 0 Then Goto Sub3
Waitms 500
Loop
Return

''''''''''''''''''''''''''''''

Sub3:
For H = 0 To 2
Gosub Sub2
Waitms 500
Portd = 0
Portc = 0
Waitms 500
Next
Goto Main
'-----------------------------------------------------------