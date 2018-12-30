REGBAS          EQU     $1000   Starting address for register block
PORTC           EQU     $03     Output port C
PORTB           EQU     $04
DDRC		EQU	$07	Data Direction register for port c
INCHAR 		EQU	$E51A 	Subroutine for keyboard input
OUTCRLF         EQU     $E4ED   Subroutine: gives CR and line feed
UPCASE 		EQU 	$E18F 	Subroutine: converts to uppercase
OUTSTR0         EQU     $E4FD
OUTA            EQU     $E4D1
OUTLHLF         EQU     $E4C3
OUTRHLF         EQU     $E4C7

                ORG     $0000         
TOTAL           RMB     1
        
		ORG	$C000
MAIN		LDX	#REGBAS
                JSR     INITIAL
LOOP            JSR     WELCOME
                JSR     READ
                JSR     OUTPUT
                BRA     MAIN


INITIAL         LDAA    $F0
		STAA	DDRC,X	   MS 4 bits = OUTPUTS, LS = INPUTS
                CLR     TOTAL
                RTS

WELCOME         LDX     #WELMESS       Loads ACCX with WEL_MESS
                JSR     OUTCRLF
                JSR     OUTSTR0
		JSR 	OUTCRLF
		JSR	INCHAR
		JSR	UPCASE
                CMPA    #$59
                BNE     WELCOME
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #SCAN
                JSR     OUTCRLF
                JSR     OUTSTR0
		JSR 	OUTCRLF
                JSR     OUTCRLF
                JSR     OUTCRLF
                RTS

READ            CLR     TOTAL
                LDX     #REGBAS
                LDAA    #$80
                STAA    PORTB,X

FIRST           JSR     TIMER
                LDX     #REGBAS
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL

SECOND          JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL

THIRD           JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL
                                
FOURTH          JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL
                                
FIFTH           JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL
                                
SIXTH           JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL
                                
SEVENTH         JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL
                                
EIGHTH          JSR     TIMER
                LDX     #REGBAS
                LDAA    TOTAL
                LSLA
                STAA    TOTAL
                LDAA    PORTC,X
                ANDA    #$01
                ADDA    TOTAL
                STAA    TOTAL
                RTS

TIMER           PSHA
                PSHB
                LDY     #1000
LOOP1           DEY     
                LDD     #150
LOOP2           SUBD    #01
                BNE     LOOP2
                CPY     #$0000
                BNE     LOOP1
                PULB
                PULA
                RTS

OUTPUT          LDAB    #$08
HELLO           JSR     OUTCRLF
                DECB
                BNE     HELLO
                LDX     #SENT1
                JSR     OUTSTR0
                LDAB    TOTAL
                ANDB    #$03
                LSLB
                LDX     #NOUN
                ABX
                LDX     $00,X
PRO             JSR     OUTSTR0
                LDX     #SENT2
                JSR     OUTSTR0
                LDAB    TOTAL
                ANDB    #$0C
                LSLB
                LSRB
                LSRB
                LDX     #PROFESSOR
                ABX
                LDX     $00,X
                JSR     OUTSTR0
YE              LDX     #SENT3
                JSR     OUTSTR0
                LDAB    TOTAL
                ANDB    #$30
                LSRB
                LSRB
                LSRB
                LDX     #YEARS
                ABX
                LDX     $00,X
                JSR     OUTSTR0
DESC            LDX     #SENT4
                JSR     OUTSTR0
                LDAB    TOTAL
                ANDB    #$C0
                LSRB
                LSRB
                LSRB
                LSRB
                LSRB
                LDX     #ADJ
                ABX
                LDX     $00,X
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                LDAB    #$09
HELLO2          JSR     OUTCRLF
                DECB
                BNE     HELLO2
                LDX     #REGBAS
                LDAA    #$00
                STAA    PORTB,X
                RTS


                ORG     $D000
WELMESS         FCC     '--------------------------------------------'
                FCB     $0D
                FCC     '-         UPC Reader Version 1.1           -'
                FCB     $0D
                FCC     '- Instructions:                            -'
                FCB     $0D
                FCC     '-    1.) Load paper into printer feeder.   -'
                FCB     $0D
                FCC     '-    2.) Press Y when ready to scan.       -'
                FCB     $0D
                FCC     '--------------------------------------------'
                FCB     $0D,$04

SCAN            FCC     'Scanning ...'
                FCB     $0D,$04

SENT1           FCC     'Miss Cleo says,'
                FCB     $0D
                FCC     '"In the future, you will live in a '
                FCB     $04
SENT2           FCC     ' with '
                FCB     $0D, $04
SENT3           FCC     ' for '
                FCB     $04
SENT4           FCC     ' years and be '
                FCB     $04
TECH            FCC     'Your UPC code is:  '
                FCB     $04
BIT             FCC     'Input Scan:  '
                FCB     $04

NOUN		FDB	#CARD, #CABI, #JAIL, #MANS
PROFESSOR	FDB	#TOUG, #GELO, #TREA, #CHER
YEARS		FDB	#SEVE, #SIXA, #SIXB, #FOUR
ADJ             FDB     #SUIC, #ECST, #LOCO, #DEST

CARD            FCC     'cardboard box'
                FCB     $04
CABI            FCC     'cabin'
                FCB     $04
JAIL            FCC     'jail'
                FCB     $04
MANS            FCC     'mansion'
                FCB     $04

TOUG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     