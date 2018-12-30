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
                LDAA    #$00
                STAA    PORTB,X
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

OUTPUT          LDX     #SENT1
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                JMP     CHARMATCH

CHARMATCH       LDAA    TOTAL
                ANDA    #$10
                CMPA    #$10
                BEQ     HUMAN
                JMP     NHUMAN


HUMAN           LDAA    TOTAL
                ANDA    #$08
                CMPA    #$08
                BEQ     CARE
                JMP     NCARE

CARE            LDAA    TOTAL
                ANDA    #$01
                CMPA    #$01
                BEQ     STRN
                JMP     NSTRN

STRN            LDAA    TOTAL
                ANDA    #$40
                CMPA    #$40
                BEQ     SOCIAL
                JMP     NSOCIAL

SOCIAL          LDAA    TOTAL
                ANDA    #$80
                CMPA    #$80
                BEQ     INTEL
                JMP     NINTEL

INTEL           LDAA    TOTAL
                ANDA    #$04
                CMPA    #$04
                BNE     CHAR1
                BRA     CHAR2

CHAR1           LDX     #CHAR1A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


CHAR2           LDX     #CHAR2A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


NINTEL          LDAA    TOTAL
                ANDA    #$02
                CMPA    #$02
                BNE     CHAR3
                BRA     CHAR4

CHAR3           LDX     #CHAR3A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


CHAR4           LDX     #CHAR4A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN




NSOCIAL         LDAA    TOTAL
                ANDA    #$80
                CMPA    #$80
                BNE     CHAR5
                BRA     CHAR6

CHAR5           LDX     #CHAR5A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN

CHAR6           LDX     #CHAR6A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN



NSTRN           LDAA    TOTAL
                ANDA    #$80
                BNE     CHAR7
                LDAA    TOTAL
                ANDA    #$40
                CMPA    #$40
                BNE     CHAR8
                BRA     CHAR9


CHAR7           LDX     #CHAR7A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


CHAR8           LDX     #CHAR8A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN

CHAR9           LDX     #CHAR9A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


NCARE           LDAA    TOTAL
                ANDA    #$01
                CMPA    #$01
                BNE     CHAR10
                BRA     CHAR11

CHAR10          LDX     #CHAR10A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


CHAR11          LDX     #CHAR11A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN



NHUMAN          LDAA    TOTAL
                ANDA    #$80
                CMPA    #$80
                BNE     SOCIAL2
                BRA     CHAR12

SOCIAL2         LDAA    TOTAL
                ANDA    #$40
                CMPA    #$40
                BNE     CHAR13
                LDAA    TOTAL
                ANDA    #$20
                CMPA    #$20
                BEQ     CHAR14
                LDAA    TOTAL
                ANDA    #08
                CMPA    #$08
                BNE     CHAR15
                BRA     CHAR16


CHAR12          LDX     #CHAR12A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN


CHAR13          LDX     #CHAR13A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN






CHAR14          LDX     #CHAR14A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN

CHAR15          LDX     #CHAR15A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN

CHAR16          LDX     #CHAR16A
                JSR     OUTSTR0
                JSR     OUTCRLF
                JSR     OUTCRLF
                LDX     #TECH
                JSR     OUTSTR0
                LDAA    TOTAL
                JSR     OUTLHLF
                LDAA    TOTAL
                JSR     OUTRHLF
                JMP     MAIN



                ORG     $D000
WELMESS         FCC     '--------------------------------------------'
                FCB     $0D
                FCC     '-      Character Personality Match Test    -'
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

SENT1           FCC     'Your BEST Character Match Is: '
                FCB     $04
SENT2           FCC     'See Character Guide Reference'
                FCB     $04
TECH            FCC     'Your UPC Code: '
                FCB     $04
CHAR1A          FCC     'Blossom'
                FCB     $04

CHAR2A          FCC     'Jesus'
                FCB     $04

CHAR3A          FCC     'Superman'
                FCB     $04

CHAR4A          FCC     'Bubbles'
                FCB     $04

CHAR5A          FCC     'Buttercup'
                FCB     $04

CHAR6A          FCC     'Batman'
                FCB     $04

CHAR7A          FCC     'a Clown'
                FCB     $04

CHAR8A          FCC     'Einstein'
                FCB     $04

CHAR9A          FCC     'Picasso'
                FCB     $04

CHAR10A         FCC     'Dilbert'
                FCB     $04

CHAR11A         FCC     'Darth Vader'
                FCB     $04

CHAR12A         FCC     'a Computer'
                FCB     $04

CHAR13A         FCC     'an Orange'
                FCB     $04

CHAR14A         FCC     'a Convertible'
                FCB     $04

CHAR15A         FCC     'a Monkey'
                FCB     $04

CHAR16A         FCC     'a Dog'
                FCB     $04

