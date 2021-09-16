print("1. Turn on Microwave.")
print("2. Hibernate")

firstInput = input("Select Option of your choice: ")

if firstInput == '1':
    print("--------NASCO MICROWAVE----------")
    print("The microwave has been turned on")
    print("Which Mode do you want to use?")
    print("1.Cooking Mode")
    print("2.Heating Mode")

    secondInput = input("Select Option of your choice: ")
    minutes = input("Enter the time in minutes: ")
    seconds = input("Enter the time in seconds: ")
    time = minutes+ " minutes" + " " + seconds+ " seconds"

    if secondInput == '1':
        print("The microwave will cook for " + time)
    elif secondInput == '2':
        print("The microwave will heat for " + time)
    else:
        print("You have entered an invalid response. Enter [1] or [2].")
elif firstInput == '2':
    print("The microwave has been turned off.")
else:
    print("You have entered an incorrect response. Enter [1] or [2].")






