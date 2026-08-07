# MyAir – ESP32 BLE Air Quality Monitor with Flutter App

**MyAir** is a complete air quality monitoring system. It combines an ESP32 sensor node (measuring temperature, humidity, and air quality) with a custom Flutter mobile application via **Bluetooth Low Energy (BLE)**. 

If the air quality drops below a safe threshold, the system triggers an audible (buzzer) and visual (red LED) alarm.

## 📱 Download the Mobile App (Android)

The compiled Android APK for the Flutter BLE app is available on the releases page of this repository.

<img width="429" height="960" alt="image" src="https://github.com/user-attachments/assets/518eff90-6d99-44e2-98da-65fff12abb5d" />
<img width="1920" height="1080" alt="Wiring" src="https://github.com/user-attachments/assets/9887b363-b812-4f22-bb1a-d7b02f5d9e5f" />

> 

 How It Works

1. **ESP32 Sensor Node**:
   - Reads **Temperature & Humidity** from the DHT11 sensor.
   - Reads **Air Quality (CO2 / Smoke / Harmful gases)** from the MQ135 analog sensor.
   - Sends all this data via **BLE**
   - If MQ135 or dht11 readings exceed a threshold, the ESP32 turns ON the **Buzzer** and **Red LED** 

2. **Flutter Mobile App**:
   - Scans for and connects to the ESP32 over BLE.
   - Displays real-time Temperature, Humidity, and Air Quality and overall of all the readings giving the enviroment a rating.
   - make sure to enable permissions when asked to  and the .apk is make for api 33 .

---

##  Hardware :


| Component | Description | Qty |
| :--- | :--- | :---: |
| Microcontroller | ESP32 WROOM-32 (Dev board) | 1 |
| Temperature Sensor | DHT11 (Digital) | 1 |
| Air Quality Sensor | MQ135 (Analog - detects NH3, NOx, alcohol, benzene, smoke 3.3v flying fish version) | 1 |
| Buzzer | 3.3V Active Piezo Buzzer | 1 |
| LED | 3mm Red LED | 1 |
| Resistor | 1kΩ (for LED current limiting) | 1 |
| Power | USB-C cable | 1 |
| Connecting Wires | Jumper wires | 1 | 


##  software 

1. Install the **ESP32 Board** in Arduino IDE (or PlatformIO you can also use esp idf but .ino wont work).
2. Install required libraries shown in .ino
3. install the .ino code in hardware and esp32 folder.
4. upload the code to your ESP32.
5. the ESP32 will advertise as"MyAir_ESP32"** over BLE.


## 🛠️ How to Run the Flutter App (from Source)

how to use the source files  (iOS or Android):

1. install files from flutter files folder
2. run flutter create 
3. replace the lib folder and pubspec files and /android (you need to manualy configure for ios in the /ios folder)
   
