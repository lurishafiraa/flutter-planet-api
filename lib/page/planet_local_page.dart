import 'package:flutter/material.dart';
import 'package:resto_flutter/model/planets.dart';
import 'package:resto_flutter/api/planet_api.dart';

class PlanetLocalPage extends StatelessWidget {
  const PlanetLocalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Planets>>(
        future: PlanetApi.getPlanetsLocally(context),
        builder: (context, snapshot) {
          final planets = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('error!'));
              } else {
                return buildPlanets(planets!);
              }
          }
        },
      ),
    );
  }

  Widget buildPlanets(List<Planets> planets) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: planets.length,
        itemBuilder: (context, index) {
          final planet = planets[index];
          return ListTile(
            title: Text(planet.name),
            subtitle: Text(planet.url),
          );
        },
      );
}
