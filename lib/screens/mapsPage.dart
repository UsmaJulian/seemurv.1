import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  final lugar;

  MapsPage({Key key, this.lugar}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(5.0684762, -75.5022841);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  populateClients() {
    Firestore.instance
        .collection('client')
        .where('taskname', isEqualTo: widget.lugar)
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          initMarker(docs.documents[i].data, docs.documents[i].documentID);
        }
      }
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(request, requestId) {
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);
    //nuevo marcador
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(request['location'].latitude, request['location'].longitude),
      infoWindow: InfoWindow(
          title: request['taskname'],
          snippet: request['taskname'],
          onTap: () {}),
    );
    setState(() {
      markers[markerId] = marker;
      print(markerId);
    });
  }

  @override
  void initState() {
    populateClients();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  MapType _defaultMapType = MapType.normal;

  void _changeMapType() {
    setState(() {
      _defaultMapType =
          _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void getCurrentPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('____posicion___');
    print('$position');
  }

  void placemarkFromAddress() async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress("La Candelaria, Bogotá");
    print('____la patria___');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   title: Text('Bienvenidos a Blizzard World'),
      //   backgroundColor: Colors.blueGrey,
      // ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: Set<Marker>.of(markers.values),
            onCameraMove: _onCameraMove,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            compassEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: FloatingActionButton(
                      onPressed: () {
                        _changeMapType();
                        print('Changing the Map Type');
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // FloatingActionButton(
                  //   onPressed: _onAddMarkerButtonPressed,
                  //   materialTapTargetSize: MaterialTapTargetSize.padded,
                  //   backgroundColor: Colors.green,
                  //   child: const Icon(Icons.add_location, size: 36.0),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
