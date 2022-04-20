import 'dart:ffi';

import 'package:amnesia_place/providers/places.dart';
import 'package:amnesia_place/screens/add_place_screen.dart';
import 'package:amnesia_place/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        // actions: <Widget>[

        // ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, places, ch) => places.items.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => Container(
                          margin: const EdgeInsets.all(6.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(
                                places.items[i].image,
                              ),
                            ),
                            title: Text(
                              places.items[i].title,
                              style: TextStyle(
                                fontSize: 21,
                              ),
                            ),
                            subtitle: Text(
                              places.items[i].location.address,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailsScreen.routeName,
                                arguments: places.items[i].id,
                              );
                            },
                          ),
                        ),
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          },
          color: Colors.black,
        ),
      ),
    );
  }
}
