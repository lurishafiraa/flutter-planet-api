import 'dart:convert';

import 'package:resto_flutter/model/planet.dart';
import 'package:flutter/material.dart';
import 'package:resto_flutter/model/planets.dart';
import 'package:http/http.dart' as http;

class PlanetApi {
  static late List jsonResults;
  static String jsonNext = '';
  static String jsonPrevious = '';

  static Future<bool> setCache(String url) async {
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    jsonResults = body['results'] ?? '';
    jsonNext = body['next'] ?? '';
    jsonPrevious = body['previous'] ?? '';
    return true;
  }

  static Future<List<Planets>> searchPlanet(String query) async {
    return jsonResults.map<Planets>(Planets.fromJson).where((planet) {
      final nameLower = planet.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return (nameLower.contains(searchLower) || searchLower == '');
    }).toList();
  }

  static String next() {
    return jsonNext;
  }

  static String previous() {
    return jsonPrevious;
  }

  static Future<List<Planets>> getPlanets() async {
    const url = 'https://www.swapi.tech/api/planets';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body['results'].map<Planets>(Planets.fromJson).toList();
  }

  static Future<Planet> getPlanet(String apiUrl) async {
    String url = apiUrl;
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return Planet.fromJson(body['result']);
  }

  static Future<List<Planets>> getPlanetsLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/planets.json');
    final body = json.decode(data);
    return body.map<Planets>(Planets.fromJson).toList();
  }
}
