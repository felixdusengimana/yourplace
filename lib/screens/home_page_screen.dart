import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/great_place_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlaceProvider>(
                    builder: (context, places, child) => places.items.isEmpty
                        ? child!
                        : ListView.builder(
                            itemCount: places.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(places.items[index].image),
                              ),
                              title: Text(places.items[index].title),
                              onTap: () {
                                // go to detail page ...
                              },
                            ),
                          ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("Got no places yet, start adding some!"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AddPlaceScreen.routeName);
                              },
                              child: const Text("Add Place"))
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
