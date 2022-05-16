import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task/model/playground.dart';

dioGetMirtAmount() async {
  try {
    var response = await Dio().get(
      "https://raw.githubusercontent.com/wealth42/flutter-wealth42-hiring-assignment/master/mocks/mirt-amount.json",
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.data);
    }
  } on DioError catch (e) {
    print(e.response);
  }
}

dioPreferenceDetails() async {
  var playground;
  try {
    var response = await Dio().get(
      "https://raw.githubusercontent.com/wealth42/flutter-wealth42-hiring-assignment/master/mocks/preference-details.json",
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      //print("here1");
      playground = Playground.fromJson(data);
      // print("here2");
      print(playground.cards[0]['id']);
      //return data;
      return playground;
    } else {
      print(response.statusCode);
    }
  } on DioError catch (e) {
    print("error getting details $e");
  }
  //return playground;
}
