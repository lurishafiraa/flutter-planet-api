// ignore_for_file: unused_import

import 'dart:async';

import 'package:resto_flutter/api/planet_api.dart';
import 'package:resto_flutter/main.dart';
import 'package:resto_flutter/model/planets.dart';
import 'package:resto_flutter/page/planet_page.dart';
import 'package:resto_flutter/widget/search_widget.dart';
import 'package:flutter/material.dart';

class FilterNetworkListPage extends StatefulWidget {
  final String url;
  final String title;
  const FilterNetworkListPage(
      {Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<Planets> planets = [];
  String query = '';
  String url = '';
  Timer? debouncer;
  PlanetApi planetApi = PlanetApi();

  @override
  void initState() {
    super.initState();
    url = widget.url;
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 60),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    await PlanetApi.setCache(url);
    final planets = await PlanetApi.searchPlanet(query);

    setState(() => this.planets = planets);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: planets.length,
                itemBuilder: (context, index) {
                  final planet = planets[index];
                  return planets.isEmpty
                      ? const Center(child: Text('Empty'))
                      : buildPlanet(planet);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: PlanetApi.previous() == ''
                        ? null
                        : () => {
                              setState(() async {
                                url = PlanetApi.previous();
                                await PlanetApi.setCache(url);
                                searchPlanet(query);
                              })
                            },
                    child: const Text('Previous'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: PlanetApi.next() == ''
                        ? null
                        : () => {
                              setState(() async {
                                url = PlanetApi.next();
                                await PlanetApi.setCache(url);
                                searchPlanet(query);
                              })
                            },
                    child: const Text('Next'),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search Resto',
        onChanged: searchPlanet,
      );

  Future searchPlanet(String query) async => debounce(() async {
        final planets = await PlanetApi.searchPlanet(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.planets = planets;
        });
      });

  Widget buildPlanet(Planets planet) => ListTile(
        title: Text(planet.name),
        subtitle: Text(planet.url),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => PlanetPage(url: planet.url))),
      );
}
