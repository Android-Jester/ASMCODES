;MICROWAVE
%macro DisplayText 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 0x80
%endmacro
%macro TakeInput 2
mov eax, 3
mov ebx, 2
mov ecx, %1
mov edx, %2
int 0x80
%endmacro

section .data
outMsg db "--------NASCO MICROWAVE----------",0xa,0xd
outMsgLen equ $-outMsg

onMsg db "1.Turn On Microwave",0xa,0xd
onMsgLen equ $-onMsg

offMsg db "2.Hibernate",0xa,0xd
offMsgLen equ $-offMsg

on_Msg db "Microwave is turned On",0xa,0xd
on_MsgLen equ $-on_Msg

off_Msg db "Microwave is Hibernated",0xa,0xd
off_MsgLen equ $-off_Msg

option db "Select Option of your Choice",0xa,0xd
optionLen equ $-option

cookMsg db "3.Cooking MODE",0xa,0xd
cookMsgLen equ $-cookMsg

cook_Msg db "Microwave is in Cooking mode",0xa,0xd
cook_MsgLen equ $-cook_Msg

reheatMsg db "4.Heating MODE",0xa,0xd
reheatMsgLen equ $-reheatMsg

reheat_Msg db "Microwave is in Heating mode",0xa,0xd
reheat_MsgLen equ $-reheat_Msg

minute db "Enter the time in minutes",0xa,0xd
minutelen equ $-minute

second dq "Enter the time in seconds",0xa,0xd
secondlen equ $-second

invalidInput db "You have entered an invalid response",0xa,0xd
invalidInputLen equ $-invalidInput

;setting constant
opt1 equ '1'
opt2 equ '2'
opt3 equ '3'
opt4 equ '4'

section .bss
num resb 4
num1 resb 4
min resb 4
sec resb 4

section .text
global _start
_start:
;Display output for option
DisplayText onMsg, onMsgLen

DisplayText offMsg, offMsgLen

;Read input
TakeInput num, 4

mov dl,[num]
cmp dl,opt1
JE n01

cmp dl,opt2
JE n02

JMP exit


n01:
DisplayText outMsg, outMsgLen

DisplayText on_Msg, on_MsgLen

DisplayText option, optionLen

DisplayText cookMsg, cookMsgLen

DisplayText reheatMsg, reheatMsgLen


;Read another input
TakeInput num1, 4

mov dl,[num1]
cmp dl,opt3
JE n03

cmp dl,opt4
JE n04

JMP exit

time:
;Text requesting input to operate microwave(minute)
DisplayText minute, minutelen

TakeInput min, 4

;Text requesting time in secocnds to operate the microwave
DisplayText second, secondlen

TakeInput sec, 4
ret

n03:
call time
DisplayText cook_Msg, cook_MsgLen


mov eax,1
int 0x80

n04:
call time
DisplayText reheat_Msg, reheat_MsgLen

mov eax,1
int 0x80

n02:
DisplayText off_Msg, off_MsgLen

mov eax,1
int 0x80

exit:
DisplayText invalidInput, invalidInputLen

mov eax, 1
int 0x80

