package com.company.hello;
import java.util.Scanner;
public class Main {
public static void main(String[] args) {
Scanner colInput= new Scanner(System.in);
String optionSelect = "Select your preferred option";
System.out.println("----------NASCO MICROWAVE---------");
System.out.println("1. Turn on microwave");
System.out.println("2. Turn off Microwave");
System.out.println(optionSelect);
int firstInput;
int secondInput;
int minute;int second;
String time;
firstInput = colInput.nextInt();
if (firstInput == 1) {
System.out.println("The microwave has been turned on");
System.out.println("--------------------------------------------------------------------");
System.out.println("Which mode do you want the microwave to operate in?");
System.out.println("1.Cooking Mode");
System.out.println("2.Heating Mode");
System.out.println(optionSelect);
secondInput = colInput.nextInt();
if (secondInput == 1 || secondInput == 2) {
System.out.println("Enter the time in minutes");
minute = colInput.nextInt();
System.out.println("Enter the time in seconds");
second = colInput.nextInt();
time = minute + " minutes " + second + " seconds";
if (secondInput == 1) {
System.out.println("The microwave will cook for " + time);
}
else {
System.out.println("The microwave will heat for " + time);
}
}
else {
System.out.println("You have entered an invalid response");
}
}
else if (firstInput == 2) {
System.out.println("The microwave has been turned off");
}
else {
System.out.println("You have entered an invalid response so the microwave will be
turned off");
}