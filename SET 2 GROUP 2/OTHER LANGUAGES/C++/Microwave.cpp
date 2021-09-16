#include <iostream>
using namespace std;

int main(){
    int firstInput;
    int secondInput;
    string minutes, seconds;
    cout<<"--------NASCO MICROWAVE----------\n";
    cout<<"[1] Turn on Microwave.\n";
    cout<<"[2] Hibernate.\n";
    cout<<"Select your option: \n";
    cin>>firstInput;
        if(firstInput==1){
            cout<<"The microwave has been turned on.\n";
            cout<<"-----------------------------------------------"<<"\n";
            cout<<"Which Mode do you want to use?\n";
            cout<<"[1] Cooking Mode\n";
            cout<<"[2] Warming Mode\n";
            cin>>secondInput;
                if(secondInput==1){
                   cout<<"Enter the time in minutes: ";
                   cin>>minutes;
                   cout<<"Enter the time in seconds: ";
                   cin>>seconds;
                   cout<<"The microwave will cook for "<<minutes<<" mins " <<seconds<<" secs.\n";
                }
                else if(secondInput==2){
                     cout<<"Enter the time in minutes: ";
                   cin>>minutes;
                   cout<<"Enter the time in seconds: ";
                   cin>>seconds;
                   cout<<"The microwave will warm for "<<minutes<<" mins "<<seconds<<" secs.\n";
                }
                else{
                    cout<<"You have entered an invalid response. Enter [1] or [2].\n";
                }
        }
        else if(firstInput==2){
           cout<<"The microwave has been hibernated.\n";
        }
        else{
            cout<<"Your have entered an incorrect response.  Enter [1] or [2].\n";
        }
        return 0;
}
