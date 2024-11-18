import 'dart:ui';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Main_weather_info extends StatefulWidget {
  final String mainWeather;
  final IconData icon;
  final String climate;
  const Main_weather_info(
      {super.key,
      required this.mainWeather,
      required this.icon,
      required this.climate});

  @override
  State<Main_weather_info> createState() => _Main_weather_infoState();
}

// ignore: camel_case_types
class _Main_weather_infoState extends State<Main_weather_info> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          child: Card(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.mainWeather,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    widget.icon,
                    size: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.climate,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
