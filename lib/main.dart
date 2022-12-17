import './models/data_service.dart';
import 'package:flutter/material.dart';

import './models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;

  @override
  void dispose() {
    _cityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 133, 227, 174),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                ),
                if (_response != null)
                  Column(
                    children: [
                      Image.network(
                        _response!.iconUrl,
                        alignment: Alignment.center,
                      ),
                      Text(
                        '${_response!.cityName}',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        '${_response!.tempInfo.temperature}°',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(_response!.weatherInfo.description)
                    ],
                  ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(
                            labelText: 'Enter City Name',
                            contentPadding: EdgeInsets.only(left: 10)),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    _cityTextController.clear();
    setState(() => _response = response);
  }
}
