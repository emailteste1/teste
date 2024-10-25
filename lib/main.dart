import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? device;
  List<String> dataPoints = [];

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  void _connectToDevice() async {
    // Adicione o UUID do seu dispositivo Bluetooth aqui
    flutterBlue.scan().listen((scanResult) {
      if (scanResult.device.name == 'CanetaBluetooth') {
        device = scanResult.device;
        device!.connect();
        // Configure as notificações de acordo com o seu dispositivo
        // Exemplo: device!.services.first.characteristics.first.setNotifyValue(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sincronização da Caneta"),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(200, 275), // Dimensões do caderno em escala
          painter: DrawingPainter(dataPoints),
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<String> dataPoints;

  DrawingPainter(this.dataPoints);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    // Lógica para desenhar com base nos dados recebidos
    // Por exemplo, você pode converter os dados em coordenadas e desenhar linhas
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

