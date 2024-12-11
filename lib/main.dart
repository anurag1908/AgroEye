import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plant_disease_identification/services/disease_provider.dart';
import 'package:plant_disease_identification/src/home_page/home.dart';
import 'package:plant_disease_identification/src/home_page/models/disease_model.dart';
import 'package:plant_disease_identification/src/suggestions_page/suggestions.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiseaseAdapter());

  await Hive.openBox<Disease>('plant_diseases');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // Wrap your SplashScreen with MaterialApp
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate to the main screen after 4 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const MyApp(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://lottie.host/4661cf2b-82b6-479a-bfbd-e4bda919e12d/zHHFycBuDr.json',
          height: 600,
          width: 600,
          repeat: false,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiseaseService>(
      create: (context) => DiseaseService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Detect diseases',
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'SFRegular'),
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case Suggestions.routeName:
                    return Suggestions();
                  case Home.routeName:
                  default:
                    return const Home();
                }
              });
        },
      ),
    );
  }
}