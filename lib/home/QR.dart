import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';

class QR extends StatelessWidget {
  dynamic data;
  QR({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userId = sharedPreferences!.getString("USERID");
    //print(sharedPreferences!.getString("${userId}USERIMAGE"));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.translate("QRtitle"),
            style: sharedPreferences!.getString("Language") == "AR"
                ? TextStyle(
                    fontFamily: "galaxy",
                    fontWeight: FontWeight.bold,
                    fontSize:
                        (28 / 360) * MediaQuery.of(context).size.width, //28
                  )
                : TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        (25 / 360) * MediaQuery.of(context).size.width, //25
                  )),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!
                    .translate("QR Message"),
                style: TextStyle(
                    fontFamily: sharedPreferences!.getString("Language") == "AR"
                        ? "messiri"
                        : "merriweather"),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate("Okay"),
                        style: TextStyle(
                          fontFamily:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? "Mag"
                                  : "rye",
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )),
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            );
          });
          },
          icon: const Icon(Icons.info_outline))
        ],
      ),
      body: Center(
        child: QrImageView(
          data:
              "${sharedPreferences!.getString("${userId}USERIMAGE")}*${sharedPreferences!.getString("username")}*${data.adulls}*${data.kids}*${data.check_in}*${data.check_out}*${data.created_at.substring(0, 10)}*${data.created_at.substring(12, 16)}*${data.phone_number}*${data.status}",
          version: QrVersions.auto,
          size: 250.0,
          //foregroundColor: Colors.green,
          eyeStyle: QrEyeStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              eyeShape: QrEyeShape.square),
          dataModuleStyle: QrDataModuleStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              dataModuleShape: QrDataModuleShape.square),
        ),
      ),
    );
  }
}
