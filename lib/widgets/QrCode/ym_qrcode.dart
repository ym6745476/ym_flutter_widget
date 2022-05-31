import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// 二维码识别Widget
class YmQRCode extends StatefulWidget {
  String text;
  List<String> flashImage;

  YmQRCode({
    this.text = "将二维码放入框内，即可自动扫描",
    this.flashImage = const [],
  });

  @override
  State<StatefulWidget> createState() => _YmQRCodeState();
}

class _YmQRCodeState extends State<YmQRCode> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  double _scanArea = 150.0;
  bool _flashOn = false;
  bool _stopScan = false;

  @override
  void initState() {
    super.initState();
  }

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
    _scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;

    return Container(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        ///扫描视窗
        Positioned(
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _buildQrView(context),
          ),
        ),

        ///闪光灯
        Positioned(
          top: MediaQuery.of(context).size.height / 2 + _scanArea / 2 - 40,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              widget.flashImage.length > 1
                  ? Container(
                      child: GestureDetector(
                        child: Image.asset(_flashOn ? widget.flashImage[0] : widget.flashImage[1],
                            height: 30, fit: BoxFit.fitHeight),
                        onTap: () {
                          controller?.toggleFlash();
                          setState(() {
                            _flashOn = !_flashOn;
                          });
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height / 2 + _scanArea / 2 + 40,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red, borderRadius: 5, borderLength: 30, borderWidth: 5, cutOutSize: _scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      Barcode result = scanData;
      if(result.code != null){
        print("扫描得到的二维码：" + result.code!);
        if (!_stopScan) {
          _stopScan = true;
          Navigator.pop(context, result.code);
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
