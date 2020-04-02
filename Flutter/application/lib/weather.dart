import 'package:application/weather-details.dart';
import 'package:flutter/material.dart';

class Weather extends StatefulWidget {

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String city;
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                decoration:
                    InputDecoration(hintText: 'Entrer le nom de la ville'),
                onChanged: (ville) {
                  this.city = ville;
                },
                onSubmitted: (ville){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherDetails(city)));
                            textEditingController.text="";
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Obtenir La Météo',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherDetails(city)));
                            textEditingController.text="";
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
