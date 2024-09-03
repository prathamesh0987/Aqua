import 'dart:convert' as convert;

import 'package:aqua/model/sensor_data.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  SensorsData? sensorsData =
      SensorsData(tdsData: '0', phValue: '0', tempCelsiusValue: '0');

  SensorsData? get sensorData {
    return sensorsData;
  }

  // Future<void> initializeValues() async {
  //   FirebaseDatabase fbd = FirebaseDatabase.instance;
  //   DatabaseReference dbRef = fbd.reference().child("Sensors");
  //   int count = 1;
  //   double avgTemp = 0.0, avgTds = 0.0, avgpH = 0.0;

  //   dbRef.onValue.listen(
  //     (event) {
  //       var dataSnapshot = event.snapshot;
  //       String tempCel = dataSnapshot.value['Temp Celsius'].toStringAsFixed(2);
  //       String phVal = dataSnapshot.value['PH Value'].toStringAsFixed(2);
  //       String tdsVal = dataSnapshot.value['TDS'].toStringAsFixed(2);

  //       if (count % 10 == 0) {
  //         avgTemp /= 10;

  //         avgTds /= 10;
  //         avgpH /= 10;
  //         SensorsData sensorsDataValue = new SensorsData(
  //           tempCelsiusValue: avgTemp.toStringAsFixed(2),
  //           tdsData: avgTds.toStringAsFixed(2),
  //           phValue: avgpH.toStringAsFixed(2),
  //         );
  //         sensorsData = sensorsDataValue;
  //         count = 1;
  //         notifyListeners();
  //       } else {
  //         avgTemp += double.parse(tempCel);
  //         avgTds += double.parse(tdsVal);
  //         avgpH += double.parse(phVal);
  //         count += 1;
  //       }
  //     },
  //   );
  // }

  Future<void> initializeValues() async {
    const String URL =
        'https://api.thingspeak.com/channels/1532451/feeds.json?api_key=0V1WJ4PRFUTSDI0T&results=2';
    http.Response response = await http.get(Uri.parse(URL));

    var jsonFeedback = convert.jsonDecode(response.body)['feeds'] as List;

    // print('json feedback : ' + jsonFeedback.toString());
    SensorsData fetchedSensorsData =
        jsonFeedback.map((json) => SensorsData.fromMap(json)).last;
    sensorsData = fetchedSensorsData;

    notifyListeners();

    // String tempCel = dataSnapshot.value['Temp Celsius'].toStringAsFixed(2);
    // String phVal = dataSnapshot.value['PH Value'].toStringAsFixed(2);
    // String tdsVal = dataSnapshot.value['TDS'].toStringAsFixed(2);

    // SensorsData sensorsDataValue = new SensorsData(
    //   tempCelsiusValue: avgTemp.toStringAsFixed(2),
    //   tdsData: avgTds.toStringAsFixed(2),
    //   phValue: avgpH.toStringAsFixed(2),
    // );
    // sensorsData = sensorsDataValue;    // String tempCel = dataSnapshot.value['Temp Celsius'].toStringAsFixed(2);
    // String phVal = dataSnapshot.value['PH Value'].toStringAsFixed(2);
    // String tdsVal = dataSnapshot.value['TDS'].toStringAsFixed(2);

    // SensorsData sensorsDataValue = new SensorsData(
    //   tempCelsiusValue: avgTemp.toStringAsFixed(2),
    //   tdsData: avgTds.toStringAsFixed(2),
    //   phValue: avgpH.toStringAsFixed(2),
    // );
    // sensorsData = sensorsDataValue;
  }
}
