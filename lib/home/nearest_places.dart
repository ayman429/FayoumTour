import 'dart:math';
import 'package:flutter/material.dart';

Map<String, dynamic> location = {
  "coordinatesX": 20.545655,
  "coordinatesY": 30.545406,
};

List<Map<String, dynamic>> arr = [
  {
    "id": 9,
    "coordinatesX": 36.806389,
    "coordinatesY": 10.181667,
  },
  {
    "id": 10,
    "coordinatesX": 30.899401907923867,
    "coordinatesY": 29.27450472396298
  },
  {
    "id": 11,
    "coordinatesX": 30.982007663718733,
    "coordinatesY": 29.23885210032401
  },
  {
    "id": 12,
    "coordinatesX": 30.4192274478539,
    "coordinatesY": 29.405833973995296
  },
];

double getDistance(Map<String, dynamic> point) {
  double x1 = location['coordinatesX'];
  double y1 = location['coordinatesY'];
  double x2 = point['coordinatesX'];
  double y2 = point['coordinatesY'];
  double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  return distance;
}

List<Map<String, dynamic>> rearrangeList(List<Map<String, dynamic>> list) {
  List<Map<String, dynamic>> sortedList = List<Map<String, dynamic>>.from(list);
  sortedList.sort((a, b) => getDistance(a).compareTo(getDistance(b)));
  return sortedList;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> sortedArr = [];

  @override
  void initState() {
    super.initState();
    sortedArr = rearrangeList(arr);
  }

  List<double> getDistances() {
    List<double> distances = [];
    for (int i = 0; i < sortedArr.length; i++) {
      double distance = getDistance(sortedArr[i]);
      distances.add(distance);
    }
    return distances;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: sortedArr.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title:
                Text('Distance ${index + 1}: ${getDistance(sortedArr[index])}'),
            subtitle: Text('ID: ${sortedArr[index]['id']}'),
          );
        },
      ),
    );
  }
}
