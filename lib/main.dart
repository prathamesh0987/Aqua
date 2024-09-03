import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aqua/providers/data_provider.dart';
import 'package:aqua/widget/internet_connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    final myTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Color(0xffA6B1E1),
          displayColor: Color(0xffA6B1E1),
          decorationColor: Color(0xffA6B1E1),
          fontFamily: GoogleFonts.lato().fontFamily,

          //2e6f95, 89c2d9
        );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        locale: Locale('en'),
        supportedLocales: [
          const Locale('en'), // English, no country code
          const Locale('hn'), // Marathi, no country code
        ],
        localizationsDelegates: [
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
              useCountryCode: false,
              basePath: 'assets/i18n',
              fallbackFile: 'en',
              forcedLocale: Locale('en'),
              decodeStrategies: [JsonDecodeStrategy()],
            ),
            missingTranslationHandler: (key, locale) {
              print(
                  "--- Missing Key: $key, languageCode: ${locale!.languageCode}");
            },
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        // builder: FlutterI18n.rootAppBuilder() as Widget Function(BuildContext, Widget?)?,
        home: MySplashScreen(),
        theme: ThemeData(
          primaryColor: Color(0xFF001C5A),
          textTheme: myTextTheme,

          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(
              Color(0xFF3C8DAD),
            ),
          ).copyWith(
            secondary: Color(0xFF3C8DAD),
          ),
          // colorScheme: ColorScheme.fromSwatch().copyWith(
          //   secondary: Color(0xFF3C8DAD),
          // ),
        ),
      ),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (connectivity == ConnectivityResult.none) {
            return InternetConnectionLost();
          } else {
            Future.delayed(
              Duration(seconds: 7),
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            );
            return child;
          }
        },
        builder: (BuildContext context) {
          return Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Lottie.asset('assets/splScreen.json'),
                ),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     CircularProgressIndicator(
                //       color: Color(0xffA6B1E1),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Text(
                //       'Please wait...',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: SizedBox(
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: TextLiquidFill(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.monoton().fontFamily,
                        ),
                        text: 'SVR INFOTECH',
                        waveColor: Colors.blueAccent,
                        boxHeight: 95,
                        waveDuration: const Duration(seconds: 5),
                        boxBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(30),
                  //   ),
                  //   shape: BoxShape.rectangle,
                  //   border: Border.all(
                  //     color: Theme.of(context).primaryColor,
                  //     style: BorderStyle.solid,
                  //     width: 5,
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
