import 'dart:convert';

import 'package:euro_collector/collection/ui/line_slots.dart';
import 'package:euro_collector/models/country_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HandleView extends StatefulWidget {
  const HandleView({Key? key}) : super(key: key);

  @override
  _HandleViewState createState() => _HandleViewState();
}

class _HandleViewState extends State<HandleView> {
  static final reg = RegExp(r'assets/json/countries/\w+\.json');

  Future<List<CountryCoin>> loadJsonData() async {
    List<CountryCoin> list = [];

    String myAssets = await rootBundle.loadString('AssetManifest.json');
    Map<String, dynamic> map = json.decode(myAssets);
    map.removeWhere((key, value) => !key.contains(reg));
    for (String path in map.keys) {
      String output = await rootBundle.loadString(path);
      list.add(CountryCoin.fromJson(json.decode(output)));
    }

    return list;
  }

  // Future<CountryCoin> loadJsonData() async {
  //   String result =
  //       await rootBundle.loadString('assets/json/countries/austria.json');
  //   return CountryCoin.fromJson(json.decode(result));
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJsonData(),
      builder: (context, snapshot) => snapshot.hasData
          ? LineSlots(data: snapshot.data as List<CountryCoin>)
          : Container(),
    );
  }
}
