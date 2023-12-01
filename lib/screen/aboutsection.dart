import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);
  LatLng myLocation1 = const LatLng(-7.247483, -55.108848);

  @override
  void initState() {
    markers.add(
      Marker(
        markerId: MarkerId(
          myLocation.toString(),
        ),
        position: myLocation,
        infoWindow: const InfoWindow(
          title: "Guitar Shop",
          snippet: "Shop",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId(
          myLocation1.toString(),
        ),
        position: myLocation1,
        infoWindow: const InfoWindow(
          title: "Brazil Branch",
          snippet: "Guitar Shop",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("aboutuspage"),
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(fontFamily: "Merienda", fontSize: 14),
        ),
        backgroundColor: const Color(0xFF535699),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  child: const Image(
                    image: AssetImage("assets/images/guitars/guitar5.jpg"),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "About Us",
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Merienda',
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Guitar Shop is the Nepal's Largest Online Musical Instrument Store, providing a solution to all customer needs. It includes a wide variety of Musical Instrument products such as: Acoustic Guitar, Semi-Acoustic Guitar, Electric Guitar, Bass Guitar, Ukuleles. This is one of the best guitar selling website of this country, giving out the best guitars available all around the world to satisfy their customers. We are ready to satisfy our customers with any means necessary handing them the best guitar suitable for them according to their guitar levels.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFF535699),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Merienda',
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 500,
                  child: GoogleMap(
                    zoomControlsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: myLocation,
                      zoom: 10,
                    ),
                    markers: markers,
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
