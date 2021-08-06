import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';
import '../providers/places.dart';

class PlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (_, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Consumer<Places>(
                    builder: (_, places, child) => places.items.isEmpty
                        ? child
                        : ListView.builder(
                            itemCount: places.items.length,
                            itemBuilder: (_, i) => ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(places.items[i].image)),
                              title: Text(places.items[i].title),
                              subtitle: Text('Location'),
                              onTap: () {},
                            ),
                          ),
                    child: Center(
                        child: Text('Got no places yet! Start exploring...')),
                  ),
      ),
    );
  }
}
