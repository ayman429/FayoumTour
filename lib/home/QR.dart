import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../core/utils/constance/shared_pref.dart';

class QR extends StatelessWidget {
  dynamic data;
  QR({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userId = sharedPreferences!.getString("USERID");
    print(sharedPreferences!.getString("${userId}USERIMAGE"));
    return Scaffold(
      body: Container(
          child: Center(
        child: QrImage(
          data:
              "${sharedPreferences!.getString("${userId}USERIMAGE")}*${sharedPreferences!.getString("username")}*${data.adulls}*${data.kids}*${data.check_in}*${data.check_out}*${data.created_at.substring(0, 10)}*${data.created_at.substring(12, 16)}*${data.phone_number}*${data.status}",
          version: QrVersions.auto,
          size: 200.0,
        ),
      )),
    );
  }
}
