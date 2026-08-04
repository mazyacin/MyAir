import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFF333331),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CosBar(),
      ),
      body: CosBody(),
    ),
  ));
}


class CosBar extends StatelessWidget {
  const CosBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.0,
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF222222),
        boxShadow: [
          BoxShadow(color: Color(0xFF575757), blurRadius: 10, offset: Offset(0, 10)),
        ],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("MyAir", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
          Text("made by Ahmed Mazouz", style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}


class CosBody extends StatefulWidget {
  const CosBody({super.key});

  @override
  State<CosBody> createState() => _CosBodyState();
}

class _CosBodyState extends State<CosBody> {
  // UI Data
  String overallQuality = "0";
  String airQuality = "0";
  String temperature = "0.0";
  String humidity = "0";
  String _status = "Tap refresh to scan";

  // BLE state
  bool _isScanning = false;
  List<ScanResult> _scanResults = [];
  BluetoothDevice? _connectedDevice;
  bool _isConnecting = false;

  // Subscriptions
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;
  StreamSubscription<bool>? _isScanningSubscription;
  StreamSubscription<List<int>>? _characteristicSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  // UUIDs
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

  @override
  void initState() {
    super.initState();

    _requestPermissions();

    _isScanningSubscription =
        FlutterBluePlus.isScanning.listen((isScanning) {
          setState(() {
            _isScanning = isScanning;
          });
        });


    _scanResultsSubscription =
        FlutterBluePlus.scanResults.listen((results) {
          setState(() {
            _scanResults = results.where((r) {
              String name = r.device.advName.isNotEmpty
                  ? r.device.advName
                  : r.device.platformName;
              return name == "MyAir";
            }).toList();
          });
        });
  }

  @override
  void dispose() {
    _scanResultsSubscription?.cancel();
    _isScanningSubscription?.cancel();
    _characteristicSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    _connectedDevice?.disconnect();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await [Permission.location, Permission.bluetoothScan, Permission.bluetoothConnect].request();
    }
  }

  void startScanning() async {
    try {
      setState(() {
        _scanResults.clear();
        _status = "Scanning...";
      });
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      setState(() => _status = "Scan Error: $e");
    }
  }


  Future<void> connectToDeviceFromList(BluetoothDevice device) async {
    try {
      // 1. Stop scanning
      _updateStatus('Stopping Scan');
      await FlutterBluePlus.stopScan();

      // 2. Wait
      await Future.delayed(const Duration(milliseconds: 500));

      // 3. Connect
      _updateStatus('Connecting');
      _connectedDevice = device;
      _isConnecting = true;

      // Listen to connection state changes for debugging
      _connectionStateSubscription?.cancel();
      _connectionStateSubscription = device.connectionState.listen((state) {
        debugPrint("BLE Event: Connection State -> $state");
        if (state == BluetoothConnectionState.disconnected) {
          setState(() {
            _status = "Disconnected";
            _connectedDevice = null;
            _isConnecting = false;
          });
        }
      });

      await device.connect(
        license: License.free,
        autoConnect: false,
        timeout: const Duration(seconds: 15),
      );

      _updateStatus('Connected');

      // 4. Discover services
      _updateStatus('Discovering Services');
      List<BluetoothService> services = await device.discoverServices();
      debugPrint("Number of discovered services: ${services.length}");

      // 5. Print every service and characteristic UUID (like debugger)
      for (var service in services) {
        debugPrint("Discovered Service UUID: ${service.uuid}");
        for (var characteristic in service.characteristics) {
          debugPrint("  -> Discovered Characteristic UUID: ${characteristic.uuid}");
        }
      }

      // 6. Find target service
      BluetoothService targetService = services.firstWhere(
            (s) => s.uuid.toString().toLowerCase() == SERVICE_UUID.toLowerCase(),
      );

      // 7. Find target characteristic
      BluetoothCharacteristic targetChar = targetService.characteristics.firstWhere(
            (c) => c.uuid.toString().toLowerCase() == CHARACTERISTIC_UUID.toLowerCase(),
      );

      // 8. Enable notifications
      await targetChar.setNotifyValue(true);
      _updateStatus('Notifications Enabled');
      debugPrint("Notifications are enabled successfully.");

      // 9. Subscribe to notifications
      _updateStatus('Receiving Data');
      _characteristicSubscription?.cancel();
      _characteristicSubscription = targetChar.onValueReceived.listen((value) {

        String hexString = value.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
        debugPrint("Raw notification bytes (Hex): $hexString");

        if (value.length >= 5) {
          // Decode
          int rawTemp = (value[0] << 8) | value[1];
          if (rawTemp > 32767) rawTemp -= 65536; //16-bit
          double temp = rawTemp / 10.0;

          int humidityValue = value[2];
          int airQualityValue = value[3];
          int gasLevelValue = value[4];

          setState(() {
            temperature = temp.toStringAsFixed(1);
            humidity = humidityValue.toString();
            overallQuality = airQualityValue.toString();
            airQuality = gasLevelValue.toString();
          });

          debugPrint(
              "Decoded -> Temp: $temperature°C, Humidity: $humidity%, Air Quality: $overallQuality, Gas Level: $airQuality");
        } else {
          debugPrint("Received packet length is less than 5 bytes: ${value.length}");
        }
      });

      // completed successfully
      setState(() {
        _status = "Connected & Receiving Data";
        _isConnecting = false;
      });
    } catch (e) {
      debugPrint("Exception during connection: $e");
      setState(() {
        _status = "Error: $e";
        _isConnecting = false;
      });

      try {
        await _connectedDevice?.disconnect();
      } catch (_) {}
    }
  }

  void _updateStatus(String status) {
    setState(() {
      _status = status;
    });
    debugPrint("BLE Status: $status");
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFF3F3F3F),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 20, offset: Offset(0, 10)),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    overallQuality,
                    style: const TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontWeight: FontWeight.bold,
                      fontSize: 75,
                      shadows: [Shadow(blurRadius: 7, color: Colors.white)],
                    ),
                  ),
                  Transform.scale(
                    scale: 1.38,
                    child: Image.asset('assets/design(1).png', fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Container(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF3F3F3F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 20, offset: Offset(0, 10)),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Air Quality",
                        style: TextStyle(
                          color: Color(0xFFE0E0E0),
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                          shadows: [Shadow(blurRadius: 3, color: Colors.white)],
                        ),
                      ),
                      const SizedBox(height: 10),
                      DeltaAssetScaleWrap(
                          child: Image.asset("assets/image(9).png",
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.air, color: Colors.white),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(width: 80),
                  Text(
                    airQuality,
                    style: const TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontWeight: FontWeight.w700,
                      fontSize: 90,
                      shadows: [Shadow(blurRadius: 7, color: Colors.white)],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                theCard("Temperature", "$temperature°C", "assets/design(3).png", scale: 1.3),
                theCard("Humidity", "$humidity%", "assets/design(2).png", scale: 1.0),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _status,
              style: const TextStyle(color: Colors.cyanAccent, fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            //DEVICE LIST
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF3F3F3F),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Text(
                          "Devices",
                          style: TextStyle(
                            color: Color(0xFFE0E0E0),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            _isScanning ? Icons.hourglass_empty : Icons.refresh,
                            color: Colors.cyanAccent,
                          ),
                          onPressed: _isScanning ? null : startScanning,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _scanResults.isEmpty
                        ? Center(
                      child: Text(
                        _isScanning ? 'Scanning...' : 'No devices found',
                        style: const TextStyle(color: Colors.white54, fontSize: 17),
                      ),
                    )
                        : ListView.builder(
                      itemCount: _scanResults.length,
                      itemBuilder: (context, index) {
                        final result = _scanResults[index];
                        final bool isConnected = _connectedDevice?.remoteId == result.device.remoteId;
                        final bool isThisConnecting = _isConnecting && _connectedDevice?.remoteId == result.device.remoteId;

                        // ===== FIXED TITLE: use device.advName =====
                        final displayName = result.device.advName.isNotEmpty
                            ? result.device.advName
                            : "Unknown";

                        return ListTile(
                          dense: true,
                          title: Text(
                            displayName,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Text(
                            result.device.remoteId.toString().substring(0, 12),
                            style: const TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                          trailing: ElevatedButton(
                            onPressed: (isConnected || isThisConnecting) ? null : () => connectToDeviceFromList(result.device),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              minimumSize: const Size(60, 30),
                            ),
                            child: Text(
                              isConnected ? 'CONNECTED' : (isThisConnecting ? '...' : 'CONNECT'),
                              style: const TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget theCard(String label, String value, String assetPath, {double scale = 1.0}) {
    return Container(
      height: 180,
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF3F3F3F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: Transform.scale(
              scale: scale,
              child: Image.asset(
                assetPath,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) => const SizedBox(height: 50, child: Icon(Icons.error, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 22,
              fontWeight: FontWeight.w800,
              shadows: [Shadow(blurRadius: 3, color: Colors.white)],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 35,
              fontWeight: FontWeight.w800,
              shadows: [Shadow(blurRadius: 3, color: Colors.white)],
            ),
          ),
        ],
      ),
    );
  }
}

class DeltaAssetScaleWrap extends StatelessWidget {
  final Widget child;
  const DeltaAssetScaleWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 80,
    child: Transform.scale(scale: 1.9, filterQuality: FilterQuality.high, child: child),
  );
}