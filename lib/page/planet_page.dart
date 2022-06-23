import 'package:resto_flutter/api/planet_api.dart';
import 'package:resto_flutter/model/planet.dart';
import 'package:flutter/material.dart';
// import 'package:belajar_api/model/planet.dart';

class PlanetPage extends StatefulWidget {
  final String url;

  const PlanetPage({Key? key, required this.url}) : super(key: key);

  @override
  State<PlanetPage> createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: PlanetApi.getPlanet(widget.url),
      builder: (context, snapshot) {
        final planet = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else {
              if (planet != null) {
                return buildPlanet(planet as Planet);
              } else {
                return const Center(
                  child: Text('error'),
                );
              }
            }
        }
      },
    ));
  }
}

Widget buildPlanet(Planet planet) => Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
      ),
      body: Center(child: Text(planet.name)),
    );
