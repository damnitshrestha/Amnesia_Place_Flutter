import 'package:amnesia_place/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../models/place.dart';
import '../helper/location_manager.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String
      _previewImageURL; //URL of the preview image of the map storing location

  Future<void> _getUserCurrentLocation() async {
    final locationData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateMapPreviewUrl(
        locationData.longitude, locationData.latitude);
    setState(() {
      _previewImageURL = staticMapImageUrl;
    });
    widget.onSelectPlace(locationData.latitude, locationData.longitude);
  }

  Future<void> _selectOnMap() async {
    final latlng.LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog:
            true, //provides the close button on top left of the map page
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) return;

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);

    final staticMapImageUrl = LocationHelper.generateMapPreviewUrl(
        selectedLocation.longitude, selectedLocation.latitude);
    setState(() {
      _previewImageURL = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
          ),
          child: _previewImageURL == null
              ? Center(
                  child: Text('No location chosen!',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                )
              : Image.network(
                  _previewImageURL,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getUserCurrentLocation,
              icon: Icon(Icons.location_on_sharp),
              label: Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map_sharp),
              label: Text('Choose on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
