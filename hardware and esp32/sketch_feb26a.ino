#include <Adafruit_Sensor.h>
#include <DHT.h>

// --- NimBLE headers ---
#include <NimBLEDevice.h>
#include <NimBLEServer.h>
#include <NimBLEUtils.h>

// --- Pin definitions ---
#define DHTPIN 4
#define DHTTYPE DHT11

const int buzzer = 19;
const int red = 18;
const int mq = 34;

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

// --- Sensor variables ---
DHT dht(DHTPIN, DHTTYPE);

unsigned long lastSensorRead = 0;
unsigned long lastBlink = 0;

const long sensorInterval = 2000;
const long blinkInterval = 2000;

int gasval = 0;
int mqval = 0;
int allval = 0;
int polval = 0;
int humival = 0;
float tempval = 0;

bool deviceConnected = false;
bool clientSubscribed = false; // Blocks notifications until Flutter finishes handshake
uint32_t notifyCounter = 0;

// --- NimBLE objects ---
NimBLEServer *pServer = nullptr;
NimBLECharacteristic *pCharacteristic = nullptr;

// --- Server callbacks ---
class MyServerCallbacks : public NimBLEServerCallbacks {
  void onConnect(NimBLEServer *pServer, NimBLEConnInfo &connInfo) override {
    deviceConnected = true;
    Serial.println();
    Serial.println("==============================");
    Serial.println("CLIENT CONNECTED");
    Serial.println("=============================");
  }

  void onDisconnect(NimBLEServer *pServer, NimBLEConnInfo &connInfo, int reason) override {
    deviceConnected = false;
    clientSubscribed = false; // Reset state on drop
    Serial.println();
    Serial.println("==============================");
    Serial.println("CLIENT DISCONNECTED");
    Serial.println("Restarting Advertising... ");
    Serial.println("==============================");
    NimBLEDevice::startAdvertising();
  }
};

class MyCharacteristicCallbacks : public NimBLECharacteristicCallbacks {
  void onSubscribe(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo &connInfo, uint16_t subValue) override {
    if (subValue == 0) {
      clientSubscribed = false;
      Serial.println("Client unsubscribed from notifications");
    } else {
      clientSubscribed = true;
      Serial.println("Client subscribed to notifications - Ready to stream!");
    }
  }
};

void setup() {
  Serial.begin(115200);

  pinMode(buzzer, OUTPUT);
  pinMode(red, OUTPUT);
  pinMode(mq, INPUT);

  dht.begin();

  Serial.println();
  Serial.println("Starting NimBLE...");

  // 1. Initialize NimBLE
  NimBLEDevice::init("MyAir");

  // 2. Explicitly match Flutter's requested MTU size
  NimBLEDevice::setMTU(512);

  // 3. Create server
  pServer = NimBLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // 4. Create service
  NimBLEService *pService = pServer->createService(SERVICE_UUID);

  // 5. Create characteristic (READ + NOTIFY)
  pCharacteristic = pService->createCharacteristic(
      CHARACTERISTIC_UUID,
      NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::NOTIFY
  );
  pCharacteristic->setCallbacks(new MyCharacteristicCallbacks());

  // 6. Start service
  pService->start();

  // 7. Start advertising
  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->enableScanResponse(true);
  pAdvertising->setName("MyAir");

  NimBLEDevice::startAdvertising();

  Serial.println("NimBLE Advertising Started");
  Serial.println("Waiting for Flutter...");
}

void loop() {
  unsigned long now = millis();

  // Read sensors
  if (now - lastSensorRead >= sensorInterval) {
    lastSensorRead = now;

    mqval = analogRead(mq);

    tempval = dht.readTemperature();
    humival = dht.readHumidity();

    if (isnan(tempval) || isnan(humival)) {
      Serial.println("DHT READ FAILED");
      tempval = 0;
      humival = 0;
    }

    gasval = map(mqval, 0, 4095, 0, 100);
    polval = (gasval + humival) / 2;
    allval = map(polval, 0, 100, 100, 0);

    // --- Serial output
    Serial.println();
    Serial.println("========== SENSOR ==========");
    Serial.print("Connected  : ");
    Serial.println(deviceConnected ? "YES" : "NO");
    Serial.print("Subscribed : ");
    Serial.println(clientSubscribed ? "YES" : "NO");
    Serial.print("Temp       : ");
    Serial.println(tempval);
    Serial.print("Humidity   : ");
    Serial.println(humival);
    Serial.print("Gas        : ");
    Serial.println(gasval);
    Serial.print("Overall    : ");
    Serial.println(allval);

    // --- Send notification ONLY when fully connected AND subscribed ---
    if (deviceConnected && clientSubscribed && pCharacteristic != nullptr) {
      int16_t tempPayload = tempval * 10;
      uint8_t tx[5];
      tx[0] = (tempPayload >> 8) & 0xFF;
      tx[1] = tempPayload & 0xFF;
      tx[2] = humival;
      tx[3] = allval;
      tx[4] = gasval;

      Serial.println("------------------------");
      Serial.println("Preparing Notification");
      Serial.printf("Packet: %02X %02X %02X %02X %02X\n",
                    tx[0], tx[1], tx[2], tx[3], tx[4]);

      pCharacteristic->setValue(tx, sizeof(tx));
      pCharacteristic->notify();

      notifyCounter++;
      Serial.print("Notification #");
      Serial.println(notifyCounter);
      Serial.println("notify() completed");
    } else if (deviceConnected && !clientSubscribed) {
      Serial.println("Waiting for Flutter to finish discovery & subscribe...");
    }
  }

  if (tempval > 40 || tempval < 10 || allval < 30) {
    if (now - lastBlink >= blinkInterval) {
      lastBlink = now;
      digitalWrite(red, !digitalRead(red));
      digitalWrite(buzzer, !digitalRead(buzzer));
    }
  } else {
    digitalWrite(red, LOW);
    digitalWrite(buzzer, LOW);
  }
}