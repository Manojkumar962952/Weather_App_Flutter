import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Weather_forcast.dart';
import 'package:weather_app/Weather_main_info.dart';
import 'package:weather_app/hourly_forecast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // double temp = 0;
  // bool isload = true;
  // String? climate;
  // double value_hum = 0;
  // double value_pre = 0;
  // double value_speed = 0;
  Future<Map<String, dynamic>> getWeatherInfo() async {
    try {
      final url = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=782e6986c1a8674d'));
      final result = json.decode(url.body);
      return result;
    } catch (e) {
      throw 'Unexpected error';
    }
  }

  @override
  void initState() {
    super.initState();

    getWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getWeatherInfo();
                  });
                },
                icon: const Icon(Icons.refresh_rounded)),
          ],
          title: const Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getWeatherInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            final temp = snapshot.data?['list'][0]['main']['temp'];
            final climate = snapshot.data?['list'][0]['weather'][0]['main'];
            final valueHum = snapshot.data?['list'][0]['main']['humidity'];
            final valuePre = snapshot.data?['list'][0]['main']['pressure'];
            final valueSpeed = snapshot.data?['list'][0]['wind']['speed'];

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Main_weather_info(
                    mainWeather: '$temp K',
                    climate: '$climate',
                    icon:
                        climate == 'clouds' ? Icons.cloud : Icons.sunny_snowing,
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hourly Forecast',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       hourly_forecast(
                  //         temp: '2678.90',
                  //         time: '11:00',
                  //         icon: Icons.cloud,
                  //       ),
                  //       hourly_forecast(
                  //         temp: '342.90',
                  //         time: '12:00',
                  //         icon: Icons.cloud,
                  //       ),
                  //       hourly_forecast(
                  //         temp: '542.90',
                  //         time: '01:00',
                  //         icon: Icons.cloud,
                  //       ),
                  //       hourly_forecast(
                  //         temp: '215.45',
                  //         time: '02:00',
                  //         icon: Icons.cloud,
                  //       ),
                  //       hourly_forecast(
                  //         temp: '456.56',
                  //         time: '03:00',
                  //         icon: Icons.cloud,
                  //       ),
                  //       hourly_forecast(
                  //         temp: '123.45',
                  //         time: '04:00',
                  //         icon: Icons.cloud,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?['cnt'] - 1,
                      itemBuilder: (context, index) {
                        final hourlyTemp =
                            snapshot.data?['list'][index + 1]['main']['temp'];
                        final hourlyTime = DateTime.parse(
                            snapshot.data?['list'][index + 1]['dt_txt']);
                        final time = DateFormat.Hm().format(hourlyTime);
                        return hourly_forecast(
                            temp: '$hourlyTemp', icon: Icons.cloud, time: time);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Weather Forecast',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      weather_forcast(
                        icon: Icons.umbrella,
                        climate: 'humidity',
                        value: '$valueHum',
                      ),
                      weather_forcast(
                        icon: Icons.water,
                        climate: 'pressure',
                        value: '$valuePre',
                      ),
                      weather_forcast(
                        icon: Icons.sunny_snowing,
                        climate: 'speed',
                        value: '$valueSpeed',
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
