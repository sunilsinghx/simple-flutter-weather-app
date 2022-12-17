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
//-----------------------------------------------------------------------------
/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', '/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
*/

//------------------------------------------------------------------------
/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_model.dart';

Future<List<Post>> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  print(response.statusCode);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: FutureBuilder<List<Post>>(
          future: futurePost,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color(0xff97FFFF),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data![index].title}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("${snapshot.data![index].body}"),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
*/

//-----------------------------------------------------------------------

/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climate App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name;
  var temp;
  var description;
  var id;

  Future getWeather() async {
    var url = Uri.parse(
        // 'https://api.openweathermap.org/data/2.5/weather?id=524901&units=metric&appid=40c068b1cc423d4d28201da81ce99ee3');
        'http://api.openweathermap.org/data/2.5/weather?q=pune&appid=40c068b1cc423d4d28201da81ce99ee3&units=metric');
    http.Response response = await http.get(url);
    var result = jsonDecode(response.body);
    print(result);

    setState(() {
      this.name = result['name'];
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.id = result['id'];
    });
  }

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 10), (timer) {
    this.getWeather();
    print('Load Function');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Center(
          child: Text('Weather App'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      name != null
                          ? 'City is' + ' ' + name.toString()
                          : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    temp != null ? '$temp °C ' : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      description != null
                          ? description.toString() + ""
                          : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                    title: Text("Temperature"),
                    trailing: Text(
                        temp != null ? temp.toString() + ' °C ' : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.city),
                    title: Text("City Id"),
                    trailing: Text(id != null ? id.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/