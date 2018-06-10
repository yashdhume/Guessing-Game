;CSCI 2050 Assignment #2 Part 2
;Created by Yash Dhume (100653618) and Aabid Mitha (100657264)

extern printf
extern scanf
extern time

global main

section .text

main:
  ;Guess Num Input output
  mov   rdi,  outputFormat2
  mov   rsi,  guessNumText
  mov   rax,  0
  call        printf

  ;Try 1 output
  mov   rdi,  outputFormat
  mov   rsi,  try1Text
  mov   rax,  0
  call        printf

  ;User Input of first Guess
  mov   rdi,  inputFormat
  mov   rsi,  userNum
  mov   rax,  0
  call        scanf

  ;Calling the time
  mov   rdi,  millis
  call        time

  ;Getting last number of the time
  mov   rdx,  0
  mov   rax,  [millis]
  mov   rcx,  10
  div   rcx
  mov   [millis], rdx

  call counter

endOfProgram:
  mov   rax,  0
  ret

counter:
  ;Checks if number is correct
  mov   rdi, [userNum]
  mov   rbx, [millis]
  cmp   rdi, rbx
  je         done

  ;Outputs wrong Try again
  mov   rdi,  outputFormat2
  mov   rsi,  guessWrongTest
  mov   rax,  0
  call        printf

  ;Output the number of Tries Text
  mov   rdi,  outputFormat
  mov   rsi,  outputWrongText2
  mov   rax,  0
  call        printf

  ;Outputs the number of tries
  mov   rdi,  outputNumFormat
  mov   rsi,  [incrament]
  mov   rax,  0
  call        printf
  mov   rdi,  outputWrongText3
  mov   rax,  0
  call        printf

  ;Ask user for number
  mov   rdi,  inputFormat
  mov   rsi,  userNum
  mov   rax,  0
  call        scanf

  ;Incrament by 1
  inc   byte  [incrament]

  ;Checks if number is correct again for last try
  mov   rdi, [userNum]
  mov   rbx, [millis]
  cmp   rdi, rbx
  je         done

  ;Goes to lost if incrment reachs 6
  cmp   byte  [incrament],  6
  je          lost

  ;Loops back
  jmp         counter

lost:
  ;If you lose
  mov   rdi,  outputFormat2
  mov   rsi,  lostText
  mov   rax,  0
  call        printf
  ret

done:
  ;If you win
  mov   rdi,  outputFormat2
  mov   rsi,  guessCorrectText
  mov   rax,  0
  call        printf

section .data
  ;Text
  guessNumText      db  "Enter a number from 0 to 10 in 5 Tries."  ,    0
  try1Text          db  "Try 1: "                                  ,    0
  guessCorrectText  db  "You Got it Congrats!"                     ,    0
  guessWrongTest    db  "Wrong Answer! Try again."                 ,    0
  lostText          db  "You Lost Your chances"                    ,    0
  outputWrongText2  db  "Try "                                     ,    0
  outputWrongText3  db  ": "                                       ,    0
  ;Variables
  millis            dq                                                  0
  incrament         dq                                                  2

  ;Formats
  inputFormat       db  "%d"                                       ,    0
  outputFormat      db  "%s"                                       ,    0
  outputFormat2     db  "%s"                                       ,    0ah, 0dh, 0
  outputNumFormat   db  "%d"                                       ,    0

section .bss
    userNum:        resb                                                100
