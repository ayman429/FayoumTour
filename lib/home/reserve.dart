import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fayoumtour/hotels/domain/entities/hotel_reservation.dart';
import 'package:fayoumtour/hotels/presentation/controller/hotels_event.dart';

import '../core/services/services_locator.dart';
import '../core/utils/constance/shared_pref.dart';
import '../core/utils/constance/strings_manager.dart';
import '../hotels/presentation/controller/hotels_bloc.dart';
import '../hotels/presentation/controller/hotels_state.dart';
import 'pay.dart';

class HotelReservationScreen extends StatefulWidget {
  int hotelId;
  HotelReservationScreen({
    Key? key,
    required this.hotelId,
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

  @override
  void initState() {
    super.initState();
    _checkInDate = DateTime.now();
    _checkOutDate = DateTime.now().add(const Duration(days: 1));
    _adults = 1;
    _kids = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reservation',
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
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
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
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
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _checkInDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              _checkOutDate.subtract(const Duration(days: 1)),
                        );
                        if (date != null) {
                          setState(() {
                            _checkInDate = date;
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
                              'Check-In',
                              style: GoogleFonts.acme(fontSize: 22.0),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '${_checkInDate.day}/${_checkInDate.month}/${_checkInDate.year}',
                              style: GoogleFonts.acme(
                                  fontSize: 22.0, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
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
                              'Check-Out',
                              style: GoogleFonts.acme(fontSize: 22.0),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${_checkOutDate.day}/${_checkOutDate.month}/${_checkOutDate.year}',
                              style: GoogleFonts.acme(
                                  fontSize: 22.0, color: Colors.green),
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: 'Adults',
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: 'Kids',
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
              BlocProvider(create: (context) {
                return getIt<HotelsBloc>();
              }, child: BlocBuilder<HotelsBloc, HotelsState>(
                  builder: (context, state) {
                return TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: submit the reservation
                      String? id = await sharedPreferences!.getString("USERID");
                      int userId = int.parse(id!);
                      HotelReservation hotelReservation = HotelReservation(
                        hotel: widget.hotelId,
                        user: userId,
                        phone_number: phone_number,
                        adulls: _adults,
                        kids: _kids,
                        check_in: _checkInDate.toString().split(' ')[0],
                        check_out: _checkOutDate.toString().split(' ')[0],
                      );
                      BlocProvider.of<HotelsBloc>(context).add(
                          AddHotelReservationEvent(
                              hotelReservation: hotelReservation));
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 10),
                  child: Text(
                    "Submit!",
                    style: GoogleFonts.rye(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18),
                  ),
                );
              })),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MySample(),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10),
                child: Text(
                  "Pay!",
                  style: GoogleFonts.rye(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
