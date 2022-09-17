import "package:flutter/material.dart";
import 'package:provider/provider.dart';

//providers
import './providers/great_place_provider.dart';

//screens
import 'screens/home_page_screen.dart';
import './screens/add_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
        title: "Your Place",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
