import 'package:resto_flutter/page/filter_network_planet.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String url = '';
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FilterNetworkListPage(
                title: 'Planetopia', url: 'https://www.swapi.tech/api/planets'),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const Scaffold(
          backgroundColor: Colors.yellow,
          body: Center(
            child: Text(
              'Resto Flutter',
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        );
      },
    );
  }
}
