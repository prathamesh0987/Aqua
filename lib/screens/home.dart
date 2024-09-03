import 'package:aqua/model/sensor_data.dart';
import 'package:aqua/providers/data_provider.dart';
import 'package:aqua/widget/internet_connection.dart';
import 'package:aqua/widget/sensor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

enum Languages { ENGLISH, HINDI }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    dataProvider.initializeValues();
    final SensorsData? sensorsData = dataProvider.sensorData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/svr.png'),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          FlutterI18n.translate(context, "title"),
          style: TextStyle(
            fontSize: 13,
          ),
        ), //'WATER QUALITY MONITORING SYSTEM'
        actions: <Widget>[
          PopupMenuButton(
            color: Theme.of(context).primaryColor,
            onSelected: (Languages selectedValue) async {
              if (selectedValue == Languages.ENGLISH) {
                // appLanguage.changeLanguage(Locale('en'));
                await FlutterI18n.refresh(
                  context,
                  Locale('en'),
                );
              } else {
                // appLanguage.changeLanguage(Locale('mr'));
                await FlutterI18n.refresh(
                  context,
                  Locale('hn'),
                );
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  FlutterI18n.translate(context, "ENGLISH"),
                ),
                value: Languages.ENGLISH,
              ),
              PopupMenuItem(
                child: Text(
                  FlutterI18n.translate(context, "HINDI"),
                ),
                value: Languages.HINDI,
              ),
            ],
          ),
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (connectivity == ConnectivityResult.none) {
            return WillPopScope(
              onWillPop: onWillPop,
              child: InternetConnectionLost(),
            );
          } else {
            return child;
          }
        },
        builder: (BuildContext context) {
          // Size size = MediaQuery.of(context).size;
          return WillPopScope(
            onWillPop: onWillPop,
            child: Container(
              color: Color(0xFF000000),
              child: sensorsData != null
                  ? ((sensorsData.tdsData == null) ||
                          (sensorsData.phValue == null) ||
                          (sensorsData.tempCelsiusValue == null))
                      ? Container(
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Lottie.asset(
                                'assets/waiting.json',
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              Center(
                                child: Text(
                                  'Device might be offline...',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Sensor(
                                  sensor: FlutterI18n.translate(context, "PH"),
                                  data: sensorsData.phValue,
                                  keyVal: 1,
                                ),
                                Sensor(
                                  sensor:
                                      FlutterI18n.translate(context, "TEMP"),
                                  data: sensorsData.tempCelsiusValue,
                                  keyVal: 2,
                                ),
                                // Sensor(
                                //   sensor: FlutterI18n.translate(context, "SALINITY"),
                                //   data: sensorsData.salanity,
                                //   keyVal: 0,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Sensor(
                                  sensor: FlutterI18n.translate(context, "TDS"),
                                  data: sensorsData.tdsData,
                                  keyVal: 3,
                                ),
                                // Sensor(
                                //   sensor: FlutterI18n.translate(context, "EC"),
                                //   data: sensorsData.ec,
                                //   keyVal: 4,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              child: Text(
                                (sensorsData.dateTime!) == null
                                    ? "Updated at : 00-00-0000, 00:00:00"
                                    : "Updated at : " +
                                        DateFormat("dd-MM-yyyy").format(
                                          DateTime.parse(sensorsData.dateTime!
                                              .split("T")[0]),
                                        ) +
                                        ", " +
                                        sensorsData.dateTime!
                                            .split("T")[1]
                                            .substring(0, 8),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              // constraints: BoxConstraints.expand(
                              //   width: double.infinity,
                              //   height: 250,
                              // ),
                              // padding: EdgeInsets.all(),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                //   // shape: BoxShape.rectangle,
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35),
                                ),
                              ),
                              child: Center(
                                child: Lottie.asset(
                                  'assets/fish.json',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              // child: Column(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       'Information about safe range.',
                              //       style: TextStyle(
                              //         fontSize: 18,
                              //       ),
                              //     ),
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           '1)   pH value : ',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Text(
                              //           'Good between',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         Text(
                              //           ' 6.5 - 8.5',
                              //           style: TextStyle(
                              //             fontSize: 17,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.green,
                              //             decoration: TextDecoration.underline,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           '2)   Temperature value : ',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Text(
                              //           'Good between',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         Text(
                              //           ' 20 - 30',
                              //           style: TextStyle(
                              //             fontSize: 17,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.green,
                              //             decoration: TextDecoration.underline,
                              //           ),
                              //         ),
                              //       ],
                              //     ),

                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           '3)   DO value : ',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         Text(
                              //           'Good between',
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         Text(
                              //           ' 0 - 300',
                              //           style: TextStyle(
                              //             fontSize: 17,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.green,
                              //             decoration: TextDecoration.underline,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     // Text(
                              //     //   '4)   EC value : Good between 0 - 900',
                              //     //   style: TextStyle(fontSize: 14, color: Colors.white),
                              //     // ),
                              //   ],
                              // ),
                            ),
                          ],
                        )
                  : Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xFFA6B1E1),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Please wait, loading...',
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press again to exit apps');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
