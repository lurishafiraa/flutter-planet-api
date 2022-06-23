class Planets {
  final String uid;
  final String name;
  final String url;

  const Planets({
    required this.uid,
    required this.name,
    required this.url,
  });

  static Planets fromJson(json) => Planets(
        uid: json['uid'],
        name: json['name'],
        url: json['url'],
      );
}
