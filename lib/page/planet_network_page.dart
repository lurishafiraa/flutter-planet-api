import 'package:flutter/material.dart';
import 'package:resto_flutter/model/planets.dart';
import 'package:resto_flutter/api/planet_api.dart';
import 'planet_page.dart';

class PlanetNetworkPage extends StatelessWidget {
  const PlanetNetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Planets>>(
        future: PlanetApi.getPlanets(),
        builder: (context, snapshot) {
          final planets = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
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
          return planets.isEmpty
              ? const Center(child: Text('Empty'))
              : ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PlanetPage(url: planet.url))),
                  title: Text(planet.name),
                  subtitle: Text(planet.url),
                );
        },
      );
}
