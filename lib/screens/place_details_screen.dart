import 'package:amnesia_place/models/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  PlaceDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<Places>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: Text(
              'Address : ${selectedPlace.location.address}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            color: Colors.blueGrey[100],
            child: Text('View On Map'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: PlaceLocation(
                      latitude: selectedPlace.location.latitude,
                      longitude: selectedPlace.location.longitude,
                    ),
                    isSelecting: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
