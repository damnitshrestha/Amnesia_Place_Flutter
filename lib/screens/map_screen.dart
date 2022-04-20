import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 28.7041,
      longitude: 77.1025, //Coordinates of Delhi, India
    ),
    this.isSelecting = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  latlng.LatLng _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latlng.LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 7.0,
          onTap: widget.isSelecting
              ? (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                }
              : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/damnitshrey/cl1yfotmv007114pid2zm1fc3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGFtbml0c2hyZXkiLCJhIjoiY2wxeDJpcG9qMG1rejNrb2hob2ZyMzBtNCJ9.KDRBSIqJyPLeDTLB4QqYXQ',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiZGFtbml0c2hyZXkiLCJhIjoiY2wxeDJpcG9qMG1rejNrb2hob2ZyMzBtNCJ9.KDRBSIqJyPLeDTLB4QqYXQ',
              'id': 'mapbox.mapbox-streets-v8',
            },
            attributionBuilder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "© Shrestha Nand",
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
              );
            },
          ),
          MarkerLayerOptions(
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      point: _pickedLocation ??
                          latlng.LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          ),
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on_sharp,
                          color: Colors.red[600],
                          size: 35,
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
