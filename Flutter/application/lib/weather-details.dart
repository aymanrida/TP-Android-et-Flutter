import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherDetails extends StatefulWidget {
  String city;
  WeatherDetails(this.city);
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  var weatherData;
  getData(url) {
    http.get(url).then((resp) {
      setState(() {
        weatherData = json.decode(resp.body);
        print(weatherData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    String url =
        'http://openweathermap.org/data/2.5/forecast?q=${this.widget.city}&appid=b6907d289e10d714a6e88b30761fae22';
    print(url);
    this.getData(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Météo de ${widget.city}'),
          backgroundColor: Colors.red,
        ),
        body: (weatherData == null)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: weatherData == null ? 0 : weatherData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'images/${weatherData['list'][index]['weather'][0]['main'].toLowerCase()}.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "${new DateFormat('E dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(weatherData['list'][index]['dt'] * 1000000))}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${new DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(weatherData['list'][index]['dt'] * 1000000))} | ${weatherData['list'][index]['weather'][0]['main']}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${weatherData['list'][index]['main']['temp'].round()} °C",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
  }
}
