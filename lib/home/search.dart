import 'package:flutter/material.dart';

import '../TourismPlaces/presentation/screens/tourism_places_search.dart';
import '../core/utils/app_localizations.dart';
import '../core/utils/constance/shared_pref.dart';

class SEARCH extends StatefulWidget {
  const SEARCH({Key? key,}) : super(key: key);

  @override
  State<SEARCH> createState() => _SEARCHState();
}

class _SEARCHState extends State<SEARCH> {
  final TextEditingController _searchController = TextEditingController();
  int search_counter = 0;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              
                title: SizedBox(
                  height: (40/360)*MediaQuery.of(context).size.width,//40,
                  child: TextField(
                    controller: _searchController,
                    style:  TextStyle(fontSize: (16/360)*MediaQuery.of(context).size.width,//16
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.translate("Search..."),
                      suffixIcon:
                      _searchController.text.isNotEmpty
                          ? InkWell(
                            child: const Icon(Icons.clear),
                            onTap: () {
                              setState(() {
                                  _searchController.text = '';
                                  search_counter = 0;
                                });
                            },
                          )
                          : null,
                          
                      
                      contentPadding:  EdgeInsets.symmetric(vertical: (8/360)*MediaQuery.of(context).size.width,//8
                      ),
                      border: InputBorder.none
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      setState(() {
                        search_counter = 0;

                        _text = _searchController.text;
                      });
                    },
                    onChanged: (value) {
                      // setState(() {
                      //   // _searchController.text = _searchController.text;
                      //   // search_counter = 0;
                      //   // _text = value;
                      //   // print(_text);
                      // });
                    },
                  ),
                ),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                Container(
                  
                  margin: sharedPreferences!.getString("Language") == "AR"
                  ?  EdgeInsets.only(left: (20/360)*MediaQuery.of(context).size.width,//20
                  )
                  :  EdgeInsets.only(right: (20/360)*MediaQuery.of(context).size.width,//20
                  ),
                  child: InkWell(
                              onTap: () {
                                setState(() {
                                  search_counter = 0;
                
                                  _text = _searchController.text;
                                });
                              },
                              child: const Icon(Icons.search),
                            ),
                ),
                        
                        
              ],
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                centerTitle: true,
                
              ),
      body: _text == ""
          ? Center(
              child: Text(
                AppLocalizations.of(context)!
                    .translate("Please Write Something!"),
                style: TextStyle(
                    fontFamily: sharedPreferences!.getString("Language") == "AR"
                        ? "aref"
                        : "pressStart2p",
                    fontSize: sharedPreferences!.getString("Language") == "AR"
                        ? (38/360)*MediaQuery.of(context).size.width//38
                        : (22/360)*MediaQuery.of(context).size.width,//22,
                    height: sharedPreferences!.getString("Language") == "AR"
                        ? null
                        : 1.7,
                    color: Theme.of(context).colorScheme.primary),
              ),
            )
          : TourismPlacesSearch(textSearchByFeild: _text),
    );
  }
}
