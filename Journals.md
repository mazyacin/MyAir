---
title: "MyAir"
author: "CORE"
description: "MyAir is a complete air quality monitoring system. It combines an ESP32 sensor node (measuring temperature, humidity, and air quality) with a custom Flutter mobile application via Bluetooth Low Energy (BLE).\n\nIf the air quality drops below a safe threshold, the system triggers an audible (buzzer) and visual (red LED) alarm."
created_at: "2026-06-11"
---

# 2026-08-04: preparing files

**Total time spent: 2.0 hours**

so i finished the repo and i made a simple render for the project for the project banner and i made the demo video on youtube the first part is when under alert the second part is the reading and i cleaned the code and added comments![image](https://cdn.hackclub.com/019fcd78-c764-7dc7-a633-3b7f3e7c49e7/Untitled.png)

# 2026-08-03: IT WORKED

**Total time spent: 1.3 hours**

IT WORKED IT WORKED IT WOKRED IT WORKED you know i kinda feel bad like this project was only 20h but with this bug it went to 70h  also i made the github repo but i still havent added all the files and i had some issues building this app to apk but it was a simple fix of flutter clean and flutter pub get and the dht11 sensor wiring got messed up so i fixed it too, the app worked flawlessly , now that this project is done im gonna move on to the next one under the name "our air" :) now look at all the photos on this journal ![image](https://cdn.hackclub.com/019fc93b-b4b3-7f3c-9f30-09fcc66639dc/image.png) ![image](https://cdn.hackclub.com/019fc93b-e205-7359-b6e6-df24e5f01a5e/image.png)![image](https://cdn.hackclub.com/019fc93b-fdfc-77c3-a46b-4dd40ce035b8/image.png)![image](https://cdn.hackclub.com/019fc93c-0fc0-7bf3-a74a-69cc51a3b350/image.png)![image](https://cdn.hackclub.com/019fc93c-33b0-78c3-8568-4faa43c0a187/image.png)![image](https://cdn.hackclub.com/019fc93c-5a28-78be-bd75-3ddbc5cec0e6/image.png)![image](https://cdn.hackclub.com/019fc93c-8591-742b-83d5-d1d3102bc6e2/image.png)![image](https://cdn.hackclub.com/019fc93c-9c73-709c-a32c-6903d10041cb/image.png)![image](https://cdn.hackclub.com/019fc93c-b387-7663-b9d6-a77408076f0a/image.png)

# 2026-08-02: cntrl + v

**Total time spent: 1.0 hours**

so i moved the ble debugger logic into the app it wasnt direct i had to go line by line comparing and i added a error printer thing that shows up in ui , also i had some issues with variable naming because the debugger and app werent the same took some time![image](https://cdn.hackclub.com/019fc45c-62d4-723e-a273-5a7d32d18157/image.png)

# 2026-08-01: 67

**Total time spent: 1.5 hours**

guess what guess what the debugger worked it connected and showed data which means i just copy logic and put it in the main one , i had issues with building the debugger.apk because i switched to flutter blue plus 2.3.11 but then i went back to 2.3.10 ![image](https://cdn.hackclub.com/019fbeaf-d1f1-78eb-b747-b6d32cb5ab4f/image.png)![image](https://cdn.hackclub.com/019fbeaf-e855-7a77-a1f4-356d047c513b/image.png)![image](https://cdn.hackclub.com/019fbeaf-f99a-758d-8b79-47372ca81f73/image.png)

# 2026-07-31: im going crazy

**Total time spent: 3.0 hours**

so i fixed both the esp code and .dart code but after looking at the esp logs i realized when the app was trying to connect to esp the esp logs where saying that the esp was connected to app that means the issue isnt with connecting but with something else maybe MTU and Gatt idk  now i simplified the logic and i made a debugger app i still havent tested them , also i tried switching to flutter_reactive_ble library i kept running into errors so i switchedd back to flutter blue plus ![image](https://cdn.hackclub.com/019fb9e5-bb26-7765-8073-d91944592851/image.png)

# 2026-07-29: pinpoint

**Total time spent: 1.2 hours**

so i fixed the no name issue it took some time because im using the latest nimble version which isnt documented that good compared to other versions and i tested it and it still hangs and doesn`t connect so i checked both the .dart and .ino in the .ino there was a line where it stops advertising when connected  to client but it wont connect  to app and the other issue was in .dart it wasnt the issue to not connecting but it might make the app crash it was a array mismatch im gonna fix them when i have the chance ![image](https://cdn.hackclub.com/019fafc2-4bf2-732e-95f2-13f285fc6744/753753753.jpg)

# 2026-07-28: esp

**Total time spent: 1.5 hours**

so i switched to the nimble library had some issues because i was using the latest ver and the nimBLE.2093 was integrated to the main library and you dont need to set it in the code also i tested it but the phone wasnt detecting the esp at all not just the app and after i used light blue it turns out the esp had no device name but it was declared in code i have  to dig more into this ![image](https://cdn.hackclub.com/019faaea-81d2-7764-9a70-f46bb63a2539/image.png)

# 2026-07-27: plot twist

**Total time spent: 2.0 hours**

so i made a new version of the app and what it does is display connecting status and guess what the connection failed as you see in the photo , and after some testing with light blue and nrf connect  it turns out its an issue with the BLEDEVICE.h library honestly i thought the esp was working great now im gonna make a new version but with nimble library![image](https://cdn.hackclub.com/019fa555-b0ad-71f8-a62c-fc2725d1e1fe/753753.jpg)![image](https://cdn.hackclub.com/019fa555-c429-7bef-a192-de16db8a56d7/753753753.jpg)

# 2026-07-26: almost

**Total time spent: 2.5 hours**

so i added the device least and tested it but no devices showed up so i unpaired the MyAir bluetooth and it worked the myair showedup but when i clicked the coonnect it was stuck at connecting to Myair im making a new version that fixes that, ![image](https://cdn.hackclub.com/019fa07b-015a-7772-bd65-6e775f514f1d/925292.jpg)

# 2026-07-25: YES. . .

**Total time spent: 2.0 hours**

GUESS WHAT!!, it didnt wont the polling didnt work the last thing i can think of is to add a ble device list and you manually connect and it seems to react better than the old one ![image](https://cdn.hackclub.com/019f9b49-020f-7015-9303-bc08c2039736/image.png)

# 2026-07-24: polling

**Total time spent: 3.0 hours**

so i did a lot of research and i mean it  so i thought about changing the library but then i found something called polling that forces the app to work aka every 2 seconds checks if the app works if not if forces it to connect the bad things about it its not instant it a 2 second refresh and it uses more power so the battery will drain faster i added to the code ![image](https://cdn.hackclub.com/019f94a6-1629-7dad-b56f-4e3a29d63bfa/image.png)

# 2026-07-23: esp

**Total time spent: 2.0 hours**

so i changed the esp code to log what happens when connected and igot a good lead from it , it said that client notify was off and it was connected which the apps was connecting but not taking any of the sent data and after research it turns ouut its a cccd issue and the fix it just putting some lines before other so i did that i still havent tried the new update version but i tried the last one it didnt work![image](https://cdn.hackclub.com/019f8f17-4394-70fb-a25d-0033026f3f65/image.png)

# 2026-07-22: double checking

**Total time spent: 1.2 hours**

so i double checked the code and i even checked the pub dev for the flutter blue plus 2.3.1 and on it it didnt have any license so i removed it from my code for the .connect error to come back and after some research  it is a requirement but its not said in the pub dev and its License.free not License.nonprofit also i added autoconnect : false ![image](https://cdn.hackclub.com/019f8b4f-da53-74dc-ac1b-44c81d61fd43/image.png)

# 2026-07-21: latest

**Total time spent: 1.3 hours**

so guess what i was wrong fflutter blue plus 1.14 isnt the latest and there is a 1.32 but they both have blocking  issues and no queue for line exution what i did was go to  pub dev and look up the latest ver it was 2.3.10 and after some research it seems promising it solves a lot of the issues that the other versions had so i switched to it and i fixed the code the thing that annoyed me when fixing the code was a .connect and no matter what it was showing red (error) i did everything i know and still it wont work then i did more research turns out the 2.3.10 version needs you to add a "license: License.nonprofit"inside  the .connect() ![image](https://cdn.hackclub.com/019f84b4-cf84-7dc0-92fc-62a4a35a0e40/image.png)

# 2026-07-20: whattt

**Total time spent: 0.6 hours**

so i did some research guess what, there is no official flutter blue plus 1.32.1version  its only experimental so i switched to 1.130.0 which is more reliable![image](https://cdn.hackclub.com/019f8098-94c5-72f0-8b1d-48238cdf0c63/image.png)

# 2026-07-20: idk

**Total time spent: 4.0 hours**

idk like really i have really high hopes and bigger ideas for this project but it seems like it wont work i asked gemini it said to use lastvaluerecieved but in a new chat it says to use onvaluerecieved and after too much debugging guess what i got the same error gradle assemble error and the whole project folder got messed up i thought it was an easy fix (it wasn`t. . .) pretty much all the .gradle files were messed up and the .yaml took some time to fix them also when i was testing it didnt work , but i have heard that realme phones are known to have issues with ble im gonna find another phone that not realme and is api 33 ![image](https://cdn.hackclub.com/019f7f85-dc26-76f7-a33e-c13cd3b26874/image.png)

# 2026-07-18: loose cables

**Total time spent: 2.0 hours**

i didnt test the app yet but i tested the esp and after days of not touching the bread board it definetly didnt work i fixed the loose jumper wires and i uploaded the new esp32 code also i made the wiring diagram at first i was gonna make it in circuit canvas but they didnt have my esp devkit and sensors so i went to draw.io but i couldn`t figure out how to draw so i just went to canva and made it ![image](https://cdn.hackclub.com/019f76b2-2c22-738e-aec2-5cad15bcbc81/Wiring.png)

# 2026-07-17: back at it

**Total time spent: 1.5 hours**

So im back at  this project i was gonna leave it but i saw the 40 logged hours and i think its better to fix than to make a new project , alr what i did now is i researched air monetering projects that use ble flutter apps and fed them to an LLM and gave it my code to check the differances and mistakes and it found memory leak issues and my code had lastValueStream to get the data  which depended on the app sending to esp then recieved , i changed it with onValueReceived, also i added await characteristic.setNotifyValue(true); to allow the esp to push data , i also added a safe feature if (value.length < 5) return; to check if sent array is correct and not messed up![image](https://cdn.hackclub.com/019f71d0-ae99-7343-acf9-36f4ea09d59d/image.png)

# 2026-07-07: flutter  integer

**Total time spent: 1.5 hours**

so it took me sometime to re-understand what i made on the flutter code and i implemented  the integer thing and realized with updating the numbers on the ui it has to be  a string so the int data is converted to int![image](https://cdn.hackclub.com/019f3e7f-2a5e-7d1f-8277-fdf285051253/image.png)![image](https://cdn.hackclub.com/019f3e7f-6a75-7a43-81c6-b98511e2e192/image.png)

# 2026-07-05: int.sketch

**Total time spent: 1.3 hours**

well i couldnt find a phone well not really just that i didnt have enough time to test it but i did change the esp code where i changed the transfered data from a string to an integer also i had issues with the tempurature one because is has a decimal i tried removing the decimal and readding  it in the flutter app but after some thinking i realized because the package is 8 bits and allows for max 255 sometimes the tempurature can be more than 255 like it can be 26.6 C after removing decimal its 266 which is higher than 255 so i fixed it with putting the part before the decimal in its  own byte![image](https://cdn.hackclub.com/019f346c-6aec-70f2-94cb-4a7157c5a99e/image.png)

# 2026-07-04: a Clue

**Total time spent: 1.0 hours**

so i sorta took a break from this project to focus on another one that i remade because its design , well today i came back and did more testing i used another phone that was api 31 which the app does not work in but  because the layout was perfect for this phones screen at the buttom it was saying "Scanning . . ." the same print function i put in the code and i didnt even know the prints showed at the buttom i thought you had to add a text widget for it ,even though it couldnt find the esp because the app is api 33 and the phone`s is 31 im gonna try another phone which is api 33 or higher , i lost the screenshot of the app scanning so the photo you will see is a quick recreation because the phone![image](https://cdn.hackclub.com/019f2f1c-74e9-7027-bbaa-10140e91e0a5/proof.png) is dead

# 2026-06-25: Journal Title (im too tired to even think of one)

**Total time spent: 2.0 hours**

at this point idk even what to do , i checked the permissions and removed the ones for location because sometimes the phones locks the app if it has it also i had issues with the hardware like i was getting NAN and some code instead of the humidity and temperature the problem is i didnt even change anything 
after some messing with the jumper wires it worked again and l tinkered even more with the code like waiting a bit after u run the app then scan and look for the esp32 ,im starting to think about becoming a farmer. . . ![image](https://cdn.hackclub.com/019f006a-db25-7ae2-bc61-ced625b08fdc/image.png)

# 2026-06-24: its either me or this stupid bug

**Total time spent: 2.0 hours**

i installed nrf connect for debugging and connected to esp and i checked the esp32 was sending data perfectly and even when i turned on blue i got the permission ask to authorize the esp to access the myair app but when i got in the app it didnt update , i searched onlinne for people with similar issues
i added android 12+ permission still didnt work i tried using logcat that wont work i lost my type c data cable i tinkered more with the code im too tired to test it![image](https://cdn.hackclub.com/019efbd8-706c-7595-9920-9c1634ef4459/nnnnn.jpg)
![image](https://cdn.hackclub.com/019efbda-0c45-7e2e-9bd9-543768a378b7/dasda.PNG)

# 2026-06-23: newfinallast.dart

**Total time spent: 2.2 hours**

guess what i forget to fix indexes and spent too much time debugging my esp32with debugging code after some time i realized what happened and i fixed it but the stupid apk builder literally strips the ble library encrypts the variable shrinks data so the esp was communicating with the app just that it couldnt update the variables because they are messed up i made a new version and removed  the shrinking of the app ![image](https://cdn.hackclub.com/019ef658-c894-7a77-9b44-ec9e42b886f1/156165165161.PNG)![image](https://cdn.hackclub.com/019ef659-6213-7aea-9a10-d8848b53c60a/16516.jpg)![image](https://cdn.hackclub.com/019ef659-7ce0-789d-ba72-07afc713a607/6161651.jpg)![image](https://cdn.hackclub.com/019ef659-9e73-7377-9bf0-012cc7b66d36/61616561656.jpg)

# 2026-06-22: esp32+indx

**Total time spent: 2.5 hours**

so i made the esp32 code and after some testing i found that it wouldnt send data to app because there was index mismatch like the app was expecting a float data type first but it got something else  and i got this error in the serial monitor Transmitted: nan,2147483647,64,73  so i fixed that and i still havent tried the new app also there were some spacing issues that i haave to fix![image](https://cdn.hackclub.com/019ef156-28b2-7c74-989c-0db344e70f9a/156165165161.PNG)

# 2026-06-21: Gradle 2 : The Comeback

**Total time spent: 4.0 hours**

so i added the characteristic.uuid and ble functions to recieve data and update variables before it was only scan and connect and a i had lots of issue like stray bracket ,parentheses but i fixed them quickly 
the biggest problem was when i ran flutter build apk --release the gradle errors came back and after some time and looking in the Android folder files there were some mismatches i fixed them but still didnt work after a lot of looking around i found out there was a syntax error that the IDE didnt even show it wasnt on the main.dart it was in one of the Android folder files two stray stars * messed up everything well i removed them and things went smoothly i still havent tried the app on phone ![image](https://cdn.hackclub.com/019eeb7e-c0e8-7898-8366-7b7e3540855f/grade2.PNG)![image](https://cdn.hackclub.com/019eeb7f-1130-7cc1-b304-3c63f449cdbc/7275.PNG)

# 2026-06-20: finished app

**Total time spent: 4.0 hours**

so ifinished the app but  the printer wont work also i might ditch the pcb idea for now ,maybe i will make it in another project with the 3d printed enclosure , this was a really unique project for me because the flutter app is my first mobile app ![image](https://cdn.hackclub.com/019ee735-c53b-77a8-ac12-70a7e22edd56/51651.PNG)![image](https://cdn.hackclub.com/019ee735-dc37-77b2-a08f-aa894e4e6782/98198.PNG)

# 2026-06-19: app

**Total time spent: 1.5 hours**

i did  more work to the app and redid the some of the icon because they were low quality also i realized the printer problem has to do with the  the laser cartidge im gonna try to fix it , also i had problems with spacing in the flutter app  maybe i will do some changes to the ui design![image](https://cdn.hackclub.com/019ee1fe-6357-7000-9900-bae1a1a24487/951951.PNG)

# 2026-06-18: the war of toner and brackets

**Total time spent: 1.3 hours**

so  i got a laser printer to print from a friend , well lets say finding the driver was hard and took some time to setup because the printer is old , also i worked on the app and i hate flutter for one thing giving comments of containers and columns to wrong bracket i cleaned that up and the air quality container and made a new row for the bottom containers also the printer now no matter what the file is going to print it prints all black like the whole paper is black ![image](https://cdn.hackclub.com/019edc5b-a40c-7dd2-9d4e-cc7d04d2d6a7/nice.PNG)![image](https://cdn.hackclub.com/019edc5b-da57-70b6-9379-634910467c46/7537.jpg)

# 2026-06-17: almost there

**Total time spent: 3.0 hours**

i sourced a copper plate that is 30cm by 20cm  double the size but thats ok now i need to get the chemicals and i made the pdf for the traces , also i underestimated the flutter app , it took me 2 hours just to make a statefull widget and appbar also i had problems with the blue arc placement because theree was too much blank space in the .png i fixed it in photo pea also i made the other elements in the design ![image](https://cdn.hackclub.com/019ed6bd-cdb2-7134-a12e-322f86282fa0/55555.PNG)![image](https://cdn.hackclub.com/019ed6be-04c2-7e86-90e5-f71854f8c841/7275.PNG)

# 2026-06-16: testing

**Total time spent: 2.0 hours**

so i tested my esp32 with a simple script for the BLE and it works, i also landed on the design of the app(i made the photo with AI just for the proof of concept)![image](https://cdn.hackclub.com/019ed16f-9e12-79fb-b365-c56964f7d8e1/73753.PNG)![image](https://cdn.hackclub.com/019ed170-2b48-7be7-a9e4-42db962e3f2e/design.png)

# 2026-06-15: finally

**Total time spent: 3.0 hours**

i finally fixed the flutter issue and it all had to do with gradle i was going to fix it manually but whenever i  ran the main.dart they came back and i went and asked deepseek which was a bad idea as it told me to do some scripts and use weird flutter SDK but after some testing i thought it had to do with windows and i was going to install ubuntu then i tested flutter SDK 3.22.3 (Stable) and android studio Koala | 2024.1.1 instead of vscode it worked but its a bit heavy on my pc as android studio already requires 16gb ram, man i almost forget the project idea because of this problem now its fixed and finish the project![image](https://cdn.hackclub.com/019eccae-768f-79a5-828f-2f19a5e75263/753753.PNG)

# 2026-06-14: flutter and gradle

**Total time spent: 1.5 hours**

i still havent fixe the issue with flutter and vscode i got the emulator to work but when i run script it says "Could not determine the dependencies of task ':app:compileDebugJavaWithJavac'.
> Cannot query the value of this provider because it has no value available"no matter what i tried it wont work i will try to search for a specific flutter sdk ver that works great with another android studio ver<!-- Image upload failed --> ![image](https://cdn.hackclub.com/019ec774-7efb-7f01-9f95-02083b920210/erros.PNG)

# 2026-06-13: pcb

**Total time spent: 1.5 hours**

i did the schematic and the pcb design (1 layer)im going to make it my self also i had a alot of problems with the vscode and offline emulators and im still looking at this problem ,![image](https://cdn.hackclub.com/019ec1a0-422f-76ca-b471-4d022a32bee9/1651.PNG)and did some drc the design was very simple no errors

# 2026-06-11: MyAir

**Total time spent: 13.0 hours**

u might say 13 hours is fake but i made this project just before joining macondo to use it to join a local competion but then i realized the comptetion was one of those ones where u have to use their kits and hardware, so the project was lonely on a shelf since,and i have lots of plans for it now its only on a breadboard and uses an esp32 wroom to read from an mq135 and dht11 and displays it on a webserver and had a buzzer and leds (which broke because i didnt use the project much)to alert the homeowner, now i want to switch the webserver with flutter and ble app because BLE consumes less energy also the project didnt have a battery so im going to use an 18650 shield with pass through charging so the project can stay plugged to a 5vwall socket adapter and when power is out it uses the battery and switch out the 3 leds for one rgb led and i will probably make a 1 layer pcb for it and if i can a 3d casing (the one i made on the photo) ![image](https://cdn.hackclub.com/019eb7fb-4967-7f8c-b816-0b8a317c5324/image.png)   ![image](https://cdn.hackclub.com/019eb7fa-23e9-738c-8498-0effc678ea16/image(3).png)![image](https://cdn.hackclub.com/019eb7fa-388c-7d10-8522-4e5fd4f76167/image(1).png)![image](https://cdn.hackclub.com/019eb7fa-4d97-7618-8f02-5811c5fb050d/image(2).png)![image](https://cdn.hackclub.com/019eb7fa-60c6-7055-9b08-b7fde4b045cd/Screenshot_20260331_151435.jpg)![image](https://cdn.hackclub.com/019eb7fa-89f6-78ff-aeea-f946d7dbb46a/IMG_20260331_150756.jpg)

UPDATE this is me from the future (in forge) so to the reviewer : im ok with deflation since at the time i didnt know how to use android studio with hackatime , about  the ai Usage i dont really remember much , i dont think it is over 20% , i mostly used it to get libraries and small debugging 

