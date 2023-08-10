import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fayoumtour/hotels/domain/entities/hotel_reservation.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';

import '../core/services/services_locator.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../core/utils/enums.dart';
import '../core/utils/snackbar_message.dart';
import '../hotels/presentation/controller/hotels_bloc.dart';
import '../hotels/presentation/controller/hotels_state.dart';
import 'pay.dart';
import 'package:intl/intl.dart';

class HotelReservationScreen extends StatefulWidget {
  int hotelId;
  String type;
  dynamic data;
  HotelReservationScreen({
    Key? key,
    required this.hotelId,
    required this.type,
    required this.data,
  }) : super(key: key);

  @override
  _HotelReservationScreenState createState() => _HotelReservationScreenState();
}

class _HotelReservationScreenState extends State<HotelReservationScreen> {
  late String _name;
  late String phone_number;
  late DateTime _checkInDate;
  late DateTime _checkOutDate;
  late int _adults;
  late int _kids;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data == "") {
      _checkInDate = DateTime.now();
      _checkOutDate = DateTime.now().add(const Duration(days: 1));
      _adults = 1;
      _kids = 0;
    } else {
      _textEditingController.text = widget.data.phone_number;
      _checkInDate = DateTime.parse(widget.data.check_in);
      _checkOutDate = DateTime.parse(widget.data.check_out);
      _adults = widget.data.adulls;
      _kids = widget.data.kids;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            // 'Reservation',
            AppLocalizations.of(context)!.translate("Reserve in a Hotel"),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // const SizedBox(height: 16.0),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Full Name',
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(20))),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your name';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     _name = value!;
              //   },
              // ),

              const SizedBox(height: 30.0),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)!.translate("Phone Number"),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .translate("Please enter your phone number");
                  }
                  return null;
                },
                onSaved: (value) {
                  phone_number = value!;
                },
              ),
              const SizedBox(height: 30.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _checkInDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            _checkInDate = date;
                            _checkOutDate = date.add(const Duration(days: 1));
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              // 'Check-In',
                              AppLocalizations.of(context)!
                                  .translate("Check-In"),
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ? const TextStyle(
                                      fontFamily: "amiri", fontSize: 22.0)
                                  : const TextStyle(
                                      fontFamily: "acme", fontSize: 22.0),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '${_checkInDate.day}/${_checkInDate.month}/${_checkInDate.year}',
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ? const TextStyle(
                                      fontFamily: "amiri",
                                      fontSize: 22.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      fontFamily: "acme",
                                      fontSize: 22.0,
                                      color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _checkOutDate,
                          firstDate: _checkInDate.add(const Duration(days: 1)),
                          lastDate: DateTime(2100),
                        );

                        if (date != null) {
                          setState(() {
                            _checkOutDate = date;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate("Check-Out"),
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ? const TextStyle(
                                      fontFamily: "amiri", fontSize: 22.0)
                                  : const TextStyle(
                                      fontFamily: "acme", fontSize: 22.0),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${_checkOutDate.day}/${_checkOutDate.month}/${_checkOutDate.year}',
                              style: sharedPreferences!.getString("Language") ==
                                      "AR"
                                  ? const TextStyle(
                                      fontFamily: "amiri",
                                      fontSize: 22.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      fontFamily: "acme",
                                      fontSize: 22.0,
                                      color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      borderRadius: BorderRadius.circular(30),
                      value: _adults,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText:
                            AppLocalizations.of(context)!.translate("Adults"),
                      ),
                      items: List.generate(10, (index) => index + 1)
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _adults = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      borderRadius: BorderRadius.circular(30),
                      value: _kids,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText:
                            AppLocalizations.of(context)!.translate("Kids"),
                      ),
                      items: List.generate(10, (index) => index)
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _kids = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              BlocProvider(
                create: (context) => getIt<HotelsBloc>(),
                child: BlocConsumer<HotelsBloc, HotelsState>(
                    listener: (context, state) {
                  if (state.addHotelReservationState == RequestState.loaded ||
                      state.updateHotelReservationState ==
                          RequestState.loaded) {
                    print("HotelReservation Loded");
                    BlocProvider.of<HotelsBloc>(context).add(
                        GetHotelsReservationByUserEvent(
                            userId: int.parse(
                                sharedPreferences!.getString("USERID") ??
                                    "0")));
                    // print("HotelReservation Loded");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             HotelsReservationDetailsForUser()));
                  } else if (state.addHotelReservationState ==
                          RequestState.error ||
                      state.updateHotelReservationState == RequestState.error) {
                    print("//////////////...............................");
                    Navigator.pop(context);
                    if (state.addHotelReservationMessage ==
                        '{"non_field_errors":["The fields user, hotel must make a unique set."]}') {
                      SnackBarMessage().showErrorSnackBar(
                          message:
                              sharedPreferences!.getString("Language") == "AR"
                                  ? "لقد حجزته بالفعل."
                                  : "You have already reserved it.",
                          context: context);
                    } else {
                      // print("/////////////////");
                      // print(state.addHotelReservationMessage);
                      SnackBarMessage().showErrorSnackBar(
                          message: "problem happened try again",
                          context: context);
                    }
                  }
                }, builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        String? id = sharedPreferences!.getString("USERID");
                        int userId = int.parse(id!);

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => const FractionallySizedBox(
                            widthFactor:
                                0.5, // Set the desired width factor (0.0 to 1.0)
                            child: AlertDialog(
                              content: SizedBox(
                                width: double.infinity,
                                height: 30,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        );

                        if (widget.type == "add") {
                          HotelReservation hotelReservation = HotelReservation(
                            hotel: widget.hotelId,
                            user: userId,
                            phone_number: phone_number,
                            adulls: _adults,
                            kids: _kids,
                            check_in: _checkInDate.toString().split(' ')[0],
                            check_out: _checkOutDate.toString().split(' ')[0],
                            created_at: formattedTime,
                          );
                          BlocProvider.of<HotelsBloc>(context).add(
                              AddHotelReservationEvent(
                                  hotelReservation: hotelReservation));
                        } else if (widget.type == "edit") {
                          HotelReservation hotelReservation = HotelReservation(
                            id: widget.data.id,
                            hotel: widget.hotelId,
                            user: userId,
                            phone_number: phone_number,
                            adulls: _adults,
                            kids: _kids,
                            check_in: _checkInDate.toString().split(' ')[0],
                            check_out: _checkOutDate.toString().split(' ')[0],
                          );
                          BlocProvider.of<HotelsBloc>(context).add(
                              UpdateHotelReservationEvent(
                                  hotelReservation: hotelReservation));
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        AppLocalizations.of(context)!.translate("Submit!"),
                        style: TextStyle(
                            fontFamily:
                                sharedPreferences!.getString("Language") == "AR"
                                    ? "Mag"
                                    : "rye",
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MySample(),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    AppLocalizations.of(context)!.translate("Pay!"),
                    style: TextStyle(
                        fontFamily:
                            sharedPreferences!.getString("Language") == "AR"
                                ? "Mag"
                                : "rye",
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
