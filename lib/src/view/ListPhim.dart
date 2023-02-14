import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListMoVie extends StatefulWidget {
  late String token;

  ListMoVie({required this.token});

  @override
  State<StatefulWidget> createState() {
    return _ListMoVieState(token: token);
  }
}

class _ListMoVieState extends State<ListMoVie> with WidgetsBindingObserver {
  late String token;
  List<dynamic> dataList = [];

  _ListMoVieState({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<Movie>(
          future: getListMovie(),
          builder: (context, snapshot) {
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(children: [
                    Container(child: Text('${dataList[index].name}')),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      height: 160,
                      child: FutureBuilder<Movie>(
                          future: getListMovie(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      child: Column(
                                        children: [
                                          Text('${dataList[index].name}'),
                                        ],
                                      ),
                                      onTap: () {
                                      });
                                });
                          }),
                    )
                  ]),
                );
              });
        },
      )),
    );
  }

  Future<Movie> getListMovie() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.7:3000/api/movie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print("thanh cong");
      dataList = Movie.fromJson(jsonDecode(response.body)).data!;
      print(dataList[0].name);
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState() {}

  @override
  void dispose() {}
}
