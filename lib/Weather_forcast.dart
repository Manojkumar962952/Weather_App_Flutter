import 'package:flutter/material.dart';

class weather_forcast extends StatefulWidget {
  final IconData icon;
  final String climate;
  final String value;
  const weather_forcast(
      {super.key,
      required this.climate,
      required this.icon,
      required this.value});

  @override
  State<weather_forcast> createState() => _weather_forcastState();
}

// ignore: camel_case_types
class _weather_forcastState extends State<weather_forcast> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(widget.climate),
            const SizedBox(
              height: 5,
            ),
            Icon(
              widget.icon,
              size: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(widget.value)
          ],
        ),
      ),
    );
  }
}
