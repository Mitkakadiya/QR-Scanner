import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_scanner/qr_result.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool frontCamera = false;
  bool flashOn = false;
  bool qrPause = false;
  double rotationAngle = 0.0; // Rotation angle

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildQrView(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedRotation(
                  duration: Duration(milliseconds: 500),
                  turns: rotationAngle / 360,
                  child: IconButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {
                          frontCamera = !frontCamera;
                          rotationAngle -= 180;
                        });
                      },
                      icon: Icon(
                        Icons.flip_camera_android_sharp,
                        color: Colors.white,
                      )),
                ),
                IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {
                        flashOn = !flashOn;
                      });
                    },
                    icon: Icon(
                      flashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        qrPause = !qrPause;
                      });
                      qrPause
                          ? controller?.pauseCamera()
                          : controller?.resumeCamera();
                    },
                    icon: Icon(
                      qrPause ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QrResult(
                result: result,
              ),
            ));
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
