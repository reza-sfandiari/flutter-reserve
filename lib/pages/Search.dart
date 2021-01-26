import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Search extends StatelessWidget {

  Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchFragment(key: super.key);
  }
}

class SearchFragment extends StatefulWidget {

  SearchFragment({Key key}) : super(key: key);

  @override
  _SearchFragmentState createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {

  var x = 35.7135744;
  var y = 51.4092909;

  MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(x, y),
            zoom: 16,
            onTap: (point) {
              setState(() {
                x = point.latitude;
                y = point.longitude;
              });
            },

            onLongPress: (point) {
              _mapController.move(LatLng(35.7974686,51.4330491), 16.0);
            },

          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: [
                  'a',
                  'b',
                  'c'
                ],
                additionalOptions: {
                  "accessToken":
                  "pk.eyJ1IjoiamFzaGFrb3VyaSIsImEiOiJja2NseXhia2syOHhuMnRvOHpvMDVmNzFjIn0.hUwfIHcX53fJquSoP38EIw",
                  "id": "mapbox.streets"
                }),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(x, y),
                  builder: (context) => Container(
                    child: Icon(Icons.place),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}