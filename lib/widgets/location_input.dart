import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helpers.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude!,
      longitude: locData.longitude!,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  "No location choosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: Text(
                "Current Location",
                style: TextStyle(
                  fontSize: 2 * unitHeightValue,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: Text(
                "Select on Map",
                style: TextStyle(
                  fontSize: 2 * unitHeightValue,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}
