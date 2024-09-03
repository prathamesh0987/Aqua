import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Sensor extends StatelessWidget {
  final String? data;
  final String? sensor;
  final int? keyVal;

  Sensor({this.data, this.sensor, this.keyVal});

  @override
  Widget build(BuildContext context) {
    // Color? colorValue;
    // Color red = Color(0xffFC3C3C);
    // Color green = Color(0xff5B8C5A);
    // double val = double.parse(data!);
    // switch (keyVal) {
    //   case 1:
    //     if (val < 6.5 || val > 8.5) {
    //       colorValue = red;
    //     } else {
    //       colorValue = green;
    //     }
    //     break;
    //   case 2:
    //     if (val < 20 || val > 30) {
    //       colorValue = red;
    //     } else {
    //       colorValue = green;
    //     }
    //     break;
    //   case 3:
    //     if (val < 0 || val > 300) {
    //       colorValue = red;
    //     } else {
    //       colorValue = green;
    //     }
    //     break;
    // case 4:
    //   if (val < 0 || val > 900) {
    //     colorValue = Colors.red;
    //   } else {
    //     colorValue = Colors.green;
    //   }
    //   break;
    // }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 120,
          height: 120,
          alignment: Alignment.center,
          child: Text(
            data != null ? data! : "0",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              style: BorderStyle.solid,
              width: 8,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Center(
          child: Text(
            sensor!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
