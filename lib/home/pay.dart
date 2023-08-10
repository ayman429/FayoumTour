import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class MySample extends StatefulWidget {
  const MySample({super.key});

  @override
  State<StatefulWidget> createState() {
    return MySampleState();
  }
}

class MySampleState extends State<MySample> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  final bool _isPhoneNumberFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate("Payment"),
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CreditCardWidget(
                  labelCardHolder:
                      sharedPreferences!.getString("Language") == "AR"
                          ? "اسم صاحب البطاقة"
                          : "CARD HOLDER",
                  labelValidThru:
                      sharedPreferences!.getString("Language") == "AR"
                          ? "صالح\nخلال"
                          : "VALID\nTHRU",
                  //textStyle: const TextStyle(fontFamily: 'readPro',fontSize: 12),
                  chipColor: Colors.amber,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Axis Bank',
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: const Color.fromARGB(255, 0, 0, 0),
                  backgroundImage: useBackgroundImage
                      ? 'assets/images/mastercard.png'
                      : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/images/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.green,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        cardNumberDecoration: InputDecoration(
                          //border: const OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20)) ),
                          labelText:
                              AppLocalizations.of(context)!.translate("Number"),
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: AppLocalizations.of(context)!
                              .translate("Expired Date"),
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: AppLocalizations.of(context)!
                              .translate("Card Holder"),
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: AppLocalizations.of(context)!
                                .translate("Phone Number"),
                          ),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter your phone number';
                            // }
                            // Add more validation rules here if needed
                            return null;
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _onValidate,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.translate("Validate"),
                            style: TextStyle(
                              fontFamily:
                                  sharedPreferences!.getString("Language") ==
                                          "AR"
                                      ? "Mag"
                                      : "rye",
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              //package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      //print('valid!');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!
                    .translate("This feature will be available soon!"),
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
                        primary: Colors.green,
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
    } else {
      //print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
