import 'package:flutter/material.dart';
import 'package:weather_app/helpers/weather_api_helper.dart';
import 'package:weather_app/models/weather.dart';

import 'helpers/weather_api_helper.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle myStyle = const TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  final TextEditingController searchController = TextEditingController();

  late Future<Weather?> getWeatherData;

  @override
  void initState() {
    super.initState();
    getWeatherData =
        WeatherAPIHelper.weatherAPIHelper.fetchWeatherData(city: 'surat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
      //backgroundColor: Colors.black45.withOpacity(0.5),
      body: FutureBuilder(
        future: getWeatherData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Weather? data = snapshot.data;

            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              String searchedCity = searchController.text;

                              setState(() {
                                getWeatherData = WeatherAPIHelper
                                    .weatherAPIHelper
                                    .fetchWeatherData(city: searchedCity);
                              });
                            },
                            icon: Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 30,
                                      ),
                                      Text(
                                        searchController.text,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Spacer(),
                                      Text(
                                        ("${(data!.temp - 273.15).toInt()}°C "),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      //Spacer(),
                                      Text(
                                        ("${data!.name}"),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 200,
                                  width: 300,
                                  child: (data!.name == "Haze")
                                      ? Image.asset(
                                          "assets/images/haze.png",
                                          // color: Colors.black45,
                                        )
                                      : (data!.name == "Mist")
                                          ? Image.asset(
                                              "assets/images/mist.jpg",
                                            )
                                          : (data!.name == "Clouds")
                                              ? Image.asset(
                                                  "assets/images/cloud.jpg",
                                                  //color: Colors.grey,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/clear`.jpg",
                                                ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(color: Colors.amber),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.teal,
                                  Colors.redAccent,
                                  Colors.purple,
                                  Colors.tealAccent,
                                ],
                              ),
                            ),
                            child: Text(
                              "Main:${data!.name}",
                              style: myStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(color: Colors.amber),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.teal,
                                  Colors.redAccent,
                                  Colors.purple,
                                  Colors.tealAccent,
                                ],
                              ),
                            ),
                            child: Text(
                              "Desc:${data.description}",
                              style: myStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(color: Colors.amber),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.teal,
                                  Colors.redAccent,
                                  Colors.purple,
                                  Colors.tealAccent,
                                ],
                              ),
                            ),
                            child: Text(
                              "Humidity:${data.humidity}",
                              style: myStyle,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(color: Colors.amber),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.teal,
                                  Colors.redAccent,
                                  Colors.purple,
                                  Colors.tealAccent,
                                ],
                              ),
                            ),
                            child: Text(
                              "Temp:${data.temp}",
                              style: myStyle,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(color: Colors.amber),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.teal,
                                  Colors.redAccent,
                                  Colors.purple,
                                  Colors.tealAccent,
                                ],
                              ),
                            ),
                            child: Text(
                              "wind Speed:${data.speed}",
                              style: myStyle,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(color: Colors.amber),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.teal,
                                  Colors.redAccent,
                                  Colors.purple,
                                  Colors.tealAccent,
                                ],
                              ),
                            ),
                            child: Text(
                              "wind Degree:${data.degree}",
                              style: myStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
