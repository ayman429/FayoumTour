// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GotoButton extends StatefulWidget {
  const GotoButton({super.key});

  @override
  State<GotoButton> createState() => _GotoButtonState();
}

class _GotoButtonState extends State<GotoButton> {
  static const LatLng destination =
      LatLng(29.405833973995296, 30.4192274478539);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                final url =
                    "https://www.google.com/maps/search/?api=1&query=${destination.latitude},${destination.longitude}";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text("goto")),
        ),
      ),
    );
  }
}
