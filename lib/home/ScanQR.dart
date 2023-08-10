import 'dart:developer';
import 'dart:io';

import 'package:fayoumtour/home/reservation_list_item.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';

Barcode? result;

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  // Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         // if (result != null)
          //         //   Text(
          //         //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
          //         // else
          //         //   const Text('Scan a code'),
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   crossAxisAlignment: CrossAxisAlignment.center,
          //         //   children: <Widget>[
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //           onPressed: () async {
          //         //             await controller?.toggleFlash();
          //         //             setState(() {});
          //         //           },
          //         //           child: FutureBuilder(
          //         //             future: controller?.getFlashStatus(),
          //         //             builder: (context, snapshot) {
          //         //               return Icon(Icons.flash_on);
          //         //             },
          //         //           )),
          //         //     ),
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //           onPressed: () async {
          //         //             await controller?.flipCamera();
          //         //             setState(() {});
          //         //           },
          //         //           child: FutureBuilder(
          //         //             future: controller?.getCameraInfo(),
          //         //             builder: (context, snapshot) {
          //         //               if (snapshot.data != null) {
          //         //                 return Icon(
          //         //                   Icons.flip_camera_ios_sharp,
          //         //                 );
          //         //               } else {
          //         //                 return const Text('loading');
          //         //               }
          //         //             },
          //         //           )),
          //         //     )
          //         //   ],
          //         // ),
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   crossAxisAlignment: CrossAxisAlignment.center,
          //         //   children: <Widget>[
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //         onPressed: () async {
          //         //           await controller?.pauseCamera();
          //         //         },
          //         //         child: const Text('pause',
          //         //             style: TextStyle(fontSize: 20)),
          //         //       ),
          //         //     ),
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //         onPressed: () async {
          //         //           await controller?.resumeCamera();
          //         //         },
          //         //         child: const Text('resume',
          //         //             style: TextStyle(fontSize: 20)),
          //         //       ),
          //         //     )
          //         //   ],
          //         // ),
          //       ],
          //     ),
          //   ),
          // )
        ],
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
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          List<String> dataElements = result!.code!.split('*');
          controller.pauseCamera();

          if (dataElements.length == 10) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRReserviationView(),
                ));
          } else if (dataElements.length != 10) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    sharedPreferences!.getString("Language") == "AR"
                        ? "رسالة خطأ"
                        : "Message Error",
                    style: sharedPreferences!.getString("Language") == "AR"
                        ? const TextStyle(fontFamily: "messiri")
                        : const TextStyle(fontFamily: "merriweather"),
                  ),
                  content: Text(
                    sharedPreferences!.getString("Language") == "AR"
                        ? "غير صالح"
                        : "Invalid QR",
                    style: sharedPreferences!.getString("Language") == "AR"
                        ? const TextStyle(fontFamily: "messiri")
                        : const TextStyle(fontFamily: "merriweather"),
                  ),
                  actions: <Widget>[
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.translate("Okay"),
                            style: TextStyle(
                                fontFamily:
                                    sharedPreferences!.getString("Language") ==
                                            "AR"
                                        ? "Mag"
                                        : "rye",
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          )),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                );
              },
            );
          }
          controller.resumeCamera();
        } else {
          controller.resumeCamera();
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => QRReserviationView(),
        //     ));
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QRReserviationView extends StatelessWidget {
  List<String> dataElements = result!.code!.split('*');
  late Map<String, dynamic> json;

  QRReserviationView({super.key});

  @override
  Widget build(BuildContext context) {
    json = {
      "USERIMAGE": dataElements[0],
      "username": dataElements[1],
      "adulls": dataElements[2],
      "kids": dataElements[3],
      "check_in": dataElements[4],
      "check_out": dataElements[5],
      "date": dataElements[6],
      "Time": dataElements[7],
      "phone_number": dataElements[8],
      "status": dataElements[9],
    };
    print(json);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate("QRReservation"),
            style: sharedPreferences!.getString("Language") == "AR"
                ? const TextStyle(
                    fontFamily: "galaxy",
                    fontWeight: FontWeight.bold,
                    fontSize: 28)
                : const TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ReservationListItem(data: json),
    );

    // Scaffold(
    //   body: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           for (String element in dataElements)
    //             Column(
    //               children: [
    //                 Text(element),
    //               ],
    //             ),
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => DashBoardScreen(select: 0),
    //                   ));
    //             },
    //             child: const Text('back', style: TextStyle(fontSize: 20)),
    //           )
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
