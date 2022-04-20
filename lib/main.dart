import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places.dart';
import './screens/add_place_screen.dart';
import './screens/place_details_screen.dart';
import './screens/places_list_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          fontFamily: 'Lato',
          
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
