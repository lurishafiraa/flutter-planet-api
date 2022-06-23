class Planet {
  final String diameter;
  final String rotationPeriod;
  final String orbitalPeriod;
  final String gravity;
  final String population;
  final String climate;
  final String terrain;
  final String surfaceWater;
  final String name;
  final String description;
  final String id;

  const Planet({
    required this.diameter,
    required this.rotationPeriod,
    required this.orbitalPeriod,
    required this.gravity,
    required this.population,
    required this.climate,
    required this.terrain,
    required this.surfaceWater,
    required this.name,
    required this.description,
    required this.id,
  });

  static Planet fromJson(json) => Planet(
        diameter: json['properties']['diameter'],
        rotationPeriod: json['properties']['rotation_period'],
        orbitalPeriod: json['properties']['orbital_period'],
        gravity: json['properties']['gravity'],
        population: json['properties']['population'],
        climate: json['properties']['climate'],
        terrain: json['properties']['terrain'],
        surfaceWater: json['properties']['surface_water'],
        name: json['properties']['name'],
        description: json['description'],
        id: json['_id'],
      );
}
