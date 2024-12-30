include irvine32.inc
;zuma
.model
point struct
	row db 0
	col db 0
point ends

ball struct
	pos point <>
	color db 0
	mappos dd ?
ball ends

;zuma game
.data

	welcometext db "                           __      __       .__                                  __          ", 10
				db "                          /  \    /  \ ____ |  |   ____  ____   _____   ____   _/  |_  ____  ", 10
				db "                          \   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \  \   __\/  _ \ ", 10
				db "                           \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/   |  | (  <_> )", 10
				db "                            \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >  |__|  \____/ ", 10
				db "                                 \/   ____\/____      \/            \/     \/                ", 10
				db "                                      \____    /__ __  _____ _____  _____    ____            ", 10
				db "                                        /     /|  |  \/     \\__  \ \__  \  /    \           ", 10
				db "                                       /     /_|  |  /  Y Y  \/ __ \_/ __ \|   |  \          ", 10
				db "                                      /_______ \____/|__|_|  (____  (____  /___|  /          ", 10
				db "                                              \/           \/     \/     \/     \/           ", 0

	menutext db "                                                 _____                       ", 10
			 db "                                                /     \   ____   ____  __ __ ", 10
			 db "                                               /  \ /  \_/ __ \ /    \|  |  \", 10
			 db "                                              /    Y    \  ___/|   |  \  |  /", 10
			 db "                                              \____|__  /\___  >___|  /____/ ", 10
			 db "                                                      \/     \/     \/       ", 10, 10, 10
			 db "                                                  1. Start Game", 10
		     db "                                                  2. Show Instructions", 10
		     db "                                                  3. The Developer", 10
		     db "                                                  4. Exit", 0
	byetext db "                                         __________                           ", 10
			db "                                         \______   \___.__. ____              ", 10
			db "                                          |    |  _<   |  |/ __ \             ", 10
			db "                                          |    |   \\___  \  ___/             ", 10
			db "                                          |______  // ____|\___  > /\  /\  /\ ", 10
			db "                                                 \/ \/         \/  \/  \/  \/ ", 0

	developertext  db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+++++++xx++;++;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+X$$$$$&&&&&&&&$$$X$$Xx++++;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+$&&&&&&&&&&&&&&&&&&&&&&&&&&$$X+;;;;;;++++++++++++++++++xxxxxxxx", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;x$&&&&$$&&&&&&&&&&&&&&&&&&&&&&&&&Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;x$$$$$$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$$$$$&&&&&&&&&$$$XXxxxxxxxxxxxX$&&&&&&&$XXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;X$&&&&&&&&$$Xx+++++++++++++++++++xX&&&&$&&$XXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$&&&&&&&$Xx+++++++++;;;;;;;+++++++xxX&&&&$$$XXXXXXXXXXXXXXXXXXXXXXXXXX", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+$&&&&&$Xxx+++++++;;;;;;;;;;;++++++xxxX&&&$$XXXXXXXXXXXXXXXXXXXXXXXXXXX", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$$&&&Xxxx+++++++;;;;;;;;;;;;;;;+++++xx&&&&$XXXXXXXXXXXXXXXXXXXXXXXXX$$", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;x$&&&Xxxxxx++++;;;;;;;;;;;+++xxXXXXXxxX&&&$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+$&$&xxx$$$$$$$$XXx++++++xXxXXXxxxxXXX$&&&$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 10
			       db "          ;;;;;;;;;23I-0708;;;;;;;;;;;;;;x$$$XXXxxXXxxxXXXXXxxxxxXXXX$$$$X$$XxxXXX$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 10
			       db "          ;;;;;;;;;Ali Aan;;;;;;;;;;;;;;;;+xXxxxX$XXXxxxxxxXx+++Xxxxxxxxxxxx++xx$x$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 10
			       db "          ;;;;;;;;;CS3B;;;;;;;;;;;;;;;;;;;;+Xxxx++++++++++xxx+;;++++++++++;;;+++xx$&&&$$$$$$$$&$$$$$&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;++x++++++;;;+++x++;;;;;++++;;;;;;;;++x+$&&&&&&&&&&&&&&&&&&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+x++++++;++++++++;;;;;+;+++++;;;+++xxx$&&&&&&&&&&&&&&&&&&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+++++++++++++xxx+++xxx++++++++++++xX$$&&&$$$$$$$$$$$$$$$$$$$$$$$$", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;++++++++++++++++++++++++x+++++++++;;+$&&$$$$$$$$$$$$$$$$$$$$$$$$", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;++++++++++xxxxxxxxxx+++++++++++++++:::;;;$&&&&&&&&&&&&&&&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+++;;;+xxxxx++++++++++++++++++++xxxx;++;;::;;+&&&&&&&&&&&&&&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+x+;;;;+;x$Xxx+++++++++++++++++xXxXXX+:;;+;::;;;$&&&$$$$$$$&&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;++;;;;;;+;$XX$Xx+++++++++++++xX$XxxXX:::::;;:;;;+&&&&&&&&&&&&&&&&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;++;;;;;;;;;XxxX$Xxx+++++xxxX$XxxxxX;::::::;:;+:;&&&&&&&&&&&&&$$&&&&&&", 10
			       db "          ;;;;;;;;;;;;;;;;;;;;;;;;;xX$$+;;;++++;;;;;;:;xxxXX$$$$$$Xxx+xxxxx;+;::::::;;::+$$$&&&&&&&&&&$$$$$&&&", 10
			       db "          ;;;;;;;;;;;;;;;;++++;x$$$$$$$$X;;;;;;++;;;;;;:+;++++++x+++++++x;;+;:::;:;;::::X$$$$$$$$X++x$$$$$$$$$", 10
			       db "          ;;;;;;;;:;;+;:::;;x$$$$$$$$$$$x++;;::::;;;;;;++++++++xxxxxx++x;;::::;;;:::::::;X$$$$$$$$&$+;;;+X$$$$", 10
			       db "          ;;;;;;;;:;;;;+;;;X$$$$$$$$$$$x;;;;++;::::;;;;;;;;;++++++++++;;;:::;;;:::::;;::::+$$$$$$$$$&X;;;;;X$&", 10
			       db "          ;;;;;;::::;++;;+$$$$$$$$$$$$X;;:;;;;;++;;;;++++++++++++++++++;;;;;::::::;;:::::::;X$$$$$$$$&$x;;;;x$", 10
			       db "          ;;:;;+;;::::;+x$$$$$$$$$$$X+;;::::;;;;+;;;+++xxxxxxxx++x+++++;;;;:;;:::::::::::::::x$$$$$$$$&$x;;;;;", 0
			      
	instructionstext db "                      .___                 __                        __  .__                      ", 10
                     db "                      |   | ____   _______/  |________ __ __   _____/  |_|__| ____   ____   ______", 10
                     db "                      |   |/    \ /  ___/\   __\_  __ \  |  \_/ ___\   __\  |/  _ \ /    \ /  ___/", 10
                     db "                      |   |   |  \\___ \  |  |  |  | \/  |  /\  \___|  | |  (  <_> )   |  \\___ \ ", 10
                     db "                      |___|___|  /____  > |__|  |__|  |____/  \___  >__| |__|\____/|___|  /____  >", 10
                     db "                               \/     \/                          \/                    \/     \/ ", 10, 10, 10
	                 db "           Zuma is a game where you have to shoot balls to match 3 or more balls of the same color", 10
					 db "           to make them disappear. The goal is to clear all the balls before they reach the end of the path.", 10
					 db "           Use the left and right arrow keys to move the bandook and the space bar to shoot the balls.", 10
					 db "           Press esc to pause the screen.", 0
	gameovertext db "                             ________                        ________                    ._.", 10
				 db "                            /  _____/_____    _____   ____   \_____  \___  __ ___________| |", 10
				 db "                           /   \  ___\__  \  /     \_/ __ \   /   |   \  \/ // __ \_  __ \ |", 10
				 db "                           \    \_\  \/ __ \|  Y Y  \  ___/  /    |    \   /\  ___/|  | \/\|", 10
				 db "                            \______  (____  /__|_|  /\___  > \_______  /\_/  \___  >__|   __", 10
				 db "                                   \/     \/      \/     \/          \/          \/       \/", 0
	score db 0
	contcol db 0 ; color of the balls
	contcolocc db 0 ; number of balls of the same color
	lastocc dd 0 ; address of first occurence of the color
	;indexes of ball property
	rowi = 0
	coli = 1
	colori = 2
	mapposi = 3

	ballsize = sizeof ball
	numballs db 1
	balls ball 269 dup (<>)
	playerpos db 0
	;positions of player bandook
	playerbandookpos point <60,13>, <59,13>, <59, 14>, <59, 15>, <60,15>, <61,15>, <61, 14>, <61, 13>
	playerbandookchars db '|', '\','-','/','|', '\','-','/'

	currentball ball <> ; current fired ball
	currentballpos point <>	
	map1 point 269 dup(<0,0>)
	current_ball_color db 10
	next_ball_color db 10

.code
main proc
	call welcomescreen
	call menuscreen
	ret
main endp

maingame proc
	call randomize
	call clrscr
	mov edi , offset currentball
	mov dword ptr [edi+mapposi], 8

	;draw the bandook
	push '|'
	call drawplayerbandook
	mov dx, 0E3Ch
	call gotoxy
	mov eax, 'o'
	call writechar
	call generatelevel1 ; generate the first level map
	call drawgameboundary ; draw the game boundary
	
	mov edi, offset balls
	mov byte ptr [edi+colori], 10b 
	mov esi, offset map1
	mov dword ptr[balls+mapposi], esi

	mov ecx, 267
	gameloop:
		call game
		loop gameloop

	call gameoverscreen
	call exitgamescreen
	ret
maingame endp

welcomescreen proc 
	; display the welcome screen
	mov dx, 900h
	call gotoxy
	mov edx, offset welcometext
	call writestring
	mov dx, 1d00h
	call gotoxy
	call readchar
	ret
welcomescreen endp

exitgamescreen proc
	; display the bye screen
	call clrscr
	mov dx, 0c00h
	call gotoxy
	mov edx, offset byetext
	call writestring
	mov dx, 1d00h
	call gotoxy
	mov eax, 2000
	call delay
	call clrscr
	ret
exitgamescreen endp

gameoverscreen proc
	; display the game over screen
	call clrscr
	mov dx, 0a00h
	call gotoxy
	mov edx, offset gameovertext
	call writestring
	mov dx, 1d00h
	call gotoxy
	mov eax, 2000
	call delay
	call clrscr
	ret
gameoverscreen endp

menuscreen proc
	; display the main menu
	startmenu:
	call clrscr
	mov dx, 0700h
	call gotoxy
	mov edx, offset menutext
	call writestring

	call readchar

	cmp al, '1'
	je startgame

	cmp al, '2'
	je instructions

	cmp al, '3'
	je developer

	cmp al, '4'
	je exitgame

	jmp menuscreen

	startgame:
		call clrscr
		call maingame
		
		jmp startmenu
	instructions:
		structions:
		call clrscr
		mov dx, 0700h
		call gotoxy
		mov edx, offset instructionstext
		call writestring
		mov dx, 1d00h
		call gotoxy
		call readchar
		jmp startmenu
	developer:
		call clrscr
		mov dx, 0
		call gotoxy
		mov edx, offset developertext
		call writestring
		call readchar
		jmp startmenu
	exitgame:
		call exitgamescreen
		ret
		jmp startmenu
		
	ret
menuscreen endp


game proc
	pusha
	call readkey
	jz gameagay

	push ' '
	call drawplayerbandook ; clear current bandook position
	pop ebx

	cmp dx, vk_right
	je right
	cmp dx, vk_left
	je left
	cmp	dx, vk_space
	je shootball


	jmp gameagay
	; when left pressed
	left:
		inc playerpos
		cmp playerpos, 8
		jne gameagay
		mov playerpos, 0
		jmp gameagay
	; when right pressed
	right:
		dec playerpos
		cmp playerpos, -1
		jne gameagay
		mov playerpos, 7
		jmp gameagay
		
	shootball:
		mov edi, offset currentball
		mov eax, dword ptr [edi+mapposi]
		cmp eax, 8 ; if the ball is already in the map
		jne gameagay

		; draw the bandook
		mov edx, offset playerbandookpos
		add dl, playerpos
		add dl, playerpos
		; shoot the ball
		mov edi, offset currentball
		mov bx, word ptr[edx]
		xchg bl, bh
		mov word ptr [edi], bx
		mov eax, 0
		mov al, playerpos
		mov dword ptr [edi+mapposi], eax
		mov al, current_ball_color
		mov byte ptr [edi+colori], al
		mov ebx, 0
		mov bl, next_ball_color
		mov current_ball_color, bl
		call generaterandomcolor
		mov next_ball_color, al
		
	gameagay:
	mov eax, 0
	mov al,current_ball_color
	call settextcolor
	mov dx, 0E3Ch
	call gotoxy
	mov eax, 'o'
	call writechar
	mov ebx, offset playerbandookchars
	add bl, playerpos
	push [ebx]
	call drawplayerbandook
	pop ebx
	call movshootball
	call drawandmovballs
	mov eax, 10
	call delay
	popa
	ret
game endp

generaterandomcolor proc
	mov eax, 4
	call randomrange
	add al, 10
	ret
generaterandomcolor endp

movshootball proc
	pusha
	
	; clears the previous position
	mov edi, offset currentball
	mov dx, word ptr [edi]
	xchg dl, dh
	cmp dl, 5
	jle removeshootball
	cmp dl, 113
	jge removeshootball
	cmp dh, 3
	jle removeshootball
	cmp dh, 18h
	jge removeshootball
	jmp ezscn
	removeshootball:
		mov dword ptr [edi+mapposi], 8
		mov al, ' '
		call gotoxy
		call writechar
		jmp exitmovshootball
	ezscn:
	call gotoxy
	mov al, ' '
	call writechar

	mov eax, dword ptr [edi+mapposi]
	; move the ball according to the direction
	firstconditionshootball:
		cmp eax, 0
		jne secondconditionshootball
		dec byte ptr [edi+rowi]
		jmp drawshootball
	secondconditionshootball:
		cmp eax, 1
		jne thirdconditionshootball
		dec byte ptr [edi+coli]
		dec byte ptr [edi+rowi]
		jmp drawshootball
	thirdconditionshootball:
		cmp eax, 2
		jne fourthconditionshootball
		sub byte ptr [edi+coli], 2
		jmp drawshootball
	fourthconditionshootball:
		cmp eax, 3
		jne fifthconditionshootball
		dec byte ptr [edi+coli]
		inc byte ptr [edi+rowi]
		jmp drawshootball
	fifthconditionshootball:
		cmp eax, 4
		jne sixthconditionshootball
		inc byte ptr [edi+rowi]
		jmp drawshootball
	sixthconditionshootball:
		cmp eax, 5
		jne seventhconditionshootball
		inc byte ptr [edi+coli]
		inc byte ptr [edi+rowi]
		jmp drawshootball
	seventhconditionshootball:
		cmp eax, 6
		jne eighthconditionshootball
		add byte ptr [edi+coli], 2
		jmp drawshootball
	eighthconditionshootball:
		cmp eax, 7
		jne exitmovshootball
		inc byte ptr [edi+coli]
		dec byte ptr [edi+rowi]
	drawshootball:
		mov dx, word ptr currentball
		xchg dl, dh
		call gotoxy
		mov eax, 0
		mov al, byte ptr [edi + colori]
		call settextcolor
		mov al, 'o'
		call writechar
		mov eax, dword ptr [edi+mapposi]
	exitmovshootball:
	popa
	ret
movshootball endp

drawplayerbandook proc
	; draw the bandook
	push ebp
	mov ebp, esp
	pusha
	mov eax, [ebp+8]
	mov ebx, offset playerbandookpos	
	add bl, playerpos
	add bl, playerpos
	mov dx, word ptr [ebx]
	call gotoxy
	call writechar
	popa
	pop ebp
	ret
drawplayerbandook endp

drawandmovballs proc
	pusha
	mov ecx, 0
	mov cl, numballs
	mov esi, offset balls
	add esp, 2
	mov eax, offset currentball
	mov bl, byte ptr [eax + colori]
	mov byte ptr [esp + 1], bl ; color of the next ball
	mov byte ptr [esp], 0 ; should change
	mov contcol, 0
	mov contcolocc, 0
	dmloop:
		cmp cl, 0
		je exitdmloop


		mov edi, dword ptr [esi+mapposi] ; position of ball according to map
		mov dl, byte ptr [edi+rowi] ; column 
		mov dh, byte ptr [edi+coli] ; row
		cmp byte ptr [esp], 1
		je changecolors

		mov eax, offset currentball 
		cmp dx, word ptr [eax]
		jne printballs
		
		mov word ptr [eax], 0
		mov byte ptr [esp], 1
		mov bl, byte ptr [eax + colori]
		mov dword ptr [eax+mapposi], 8 
		mov byte ptr [esp+1], bl

		changecolors:
			mov al, byte ptr[esp + 1]
			mov bl, byte ptr [esi+colori]
			mov byte ptr [esi+colori], al
			mov byte ptr[esp+1], bl

		printballs:

		movzx eax, byte ptr [esi+colori] ;mov the color of the ball
		call settextcolor

		cmp al, contcol

		je contcoloccurs
		mov contcol, al
		mov contcolocc, 1
		mov lastocc, esi
		jmp aftercolocc

		contcoloccurs:
			cmp contcol, 0
			je aftercolocc
			inc contcolocc
			cmp contcolocc, 3
			jl aftercolocc
		inc score
		mov bx, dx
		mov dx, 0103h
		call gotoxy
		mov al, score
		call writeint
		call clearballs
		mov dx, bx


		aftercolocc:

		xchg dl, dh
		call gotoxy

		add edi, type word
		mov dword ptr [esi+mapposi], edi


		mov al, 'o'
		call writechar
		add esi, 7
		dec cl
		jmp dmloop
		jmp exitdmloop

	;exitdmloop2:
	;	mov al, 2
	exitdmloop:

	cmp byte ptr [esp], 0
	je genrandcol

	mov al, byte ptr [esp]
	
	jmp nextdmb
	
	genrandcol:
		call generaterandomcolor
	nextdmb:

	mov byte ptr [esi+colori], al
	mov edi, offset map1
	mov dword ptr[esi+mapposi], edi
	inc numballs
		
	popa
	sub esp, 2
	ret
	
drawandmovballs endp

clearballs proc
	pusha
	mov esi, lastocc
	movzx ecx, contcolocc
	remball:
		mov byte ptr[esi+colori], 0
		add esi, 7
		loop remball
	popa
	ret
clearballs endp

drawgameboundary proc
	pusha
	mov dx, 0205h
	call gotoxy
	mov ecx, 110
	mov eax, '_'
	drawtopboundaryline:
		call writechar
		loop drawtopboundaryline
	call gotoxy
	mov ecx, 22
	mov eax, '|'
	mov dx, 0304h
	drawleftrightboundaryline:
		mov dl, 4h
		call gotoxy
		call writechar
		mov dl, 115
		call gotoxy
		call writechar
		inc dh
		loop drawleftrightboundaryline
	mov dx, 1904h
	call gotoxy
	mov eax, '|'
	call writechar
	mov ecx, 110
	mov eax, '_'
	drawbottomboundaryline:
		call writechar
		loop drawbottomboundaryline
	mov eax, '|'
	call writechar

	popa
	ret
drawgameboundary endp

generatelevel1 proc
	pusha
	mov edi, offset map1
	mov ecx, 49
	mov al, 4
	mov bl, 110
	maketopline1:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		sub bl, 2
		add edi, type point
		loop maketopline1
	inc bl
	mov ecx, 20

	makeleftline1:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		inc al
		add edi, type point
		loop makeleftline1
	mov ecx, 49
	inc bl

	makebottomline1:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		add bl, 2
		add edi, type point
		loop makebottomline1
	mov ecx, 17
	dec bl

	makerightline1:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		dec al
		add edi, type point
		loop makerightline1
	
	mov ecx, 47

	maketopline2:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		sub bl, 2
		add edi, type point
		loop maketopline2
	
	mov ecx, 14

	makeleftline2:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		inc al
		add edi, type point
		loop makeleftline2

	mov ecx, 44
	makebottomline2:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		add bl, 2
		add edi, type point
		loop makebottomline2

	mov ecx, 7

	makerightline2:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		dec al
		add edi, type point
		loop makerightline2

	mov ecx, 20
	

	makemiddleline:
		mov byte ptr [edi+rowi], al
		mov byte ptr [edi+coli], bl
		sub bl, 2; todo: chagne this to 2
		add edi, type point
		loop makemiddleline
	
	popa
	ret
generatelevel1 endp

end main 