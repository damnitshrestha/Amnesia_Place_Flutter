import 'dart:convert';

import 'package:http/http.dart' as http;

const MAPBOX_API_KEY =
    'pk.eyJ1IjoiZGFtbml0c2hyZXkiLCJhIjoiY2wxeDJpcG9qMG1rejNrb2hob2ZyMzBtNCJ9.KDRBSIqJyPLeDTLB4QqYXQ';

class LocationHelper {
  static String generateMapPreviewUrl(double longitude, double latitude) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,13.19/600x300?access_token=$MAPBOX_API_KEY';
  }

  static Future<String> getLocationAddress(
      double longitude, double latitude) async {
    print(longitude);
    print('         $latitude');
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?limit=1&access_token=$MAPBOX_API_KEY');
    final response = await http.get(url);
    var test = json.decode(response.body);
    return test['features'][0]['place_name'];
  }
}
