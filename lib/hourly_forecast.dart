import 'package:flutter/material.dart';

class hourly_forecast extends StatefulWidget {
  final String temp;
  final IconData icon;
  final String time;

  const hourly_forecast(
      {super.key, required this.temp, required this.icon, required this.time});

  @override
  State<hourly_forecast> createState() => _hourly_forecastState();
}

class _hourly_forecastState extends State<hourly_forecast> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.temp),
            SizedBox(
              height: 5,
            ),
            Icon(
              widget.icon,
              size: 20,
            ),
            SizedBox(
              height: 5,
            ),
            Text(widget.time)
          ],
        ),
      ),
    );
  }
}
