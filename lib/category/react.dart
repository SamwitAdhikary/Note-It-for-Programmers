import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:note_it/UI/openbook.dart';
import 'package:note_it/config/palette.dart';

class ReactScreen extends StatefulWidget {
  @override
  _ReactScreenState createState() => _ReactScreenState();
}

class _ReactScreenState extends State<ReactScreen>{
  final String url = "https://samwitadhikary.github.io/jsons/react.json";
  List data;

  @override
  void initState() {
    super.initState();
    fetchReact();
  }

  fetchReact() async {
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson['react'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data != null
          ? ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final myAlgo = data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OpenBook(
                                  myAlgo['id'],
                                  myAlgo['name'],
                                  myAlgo['author'],
                                  myAlgo['tagline'],
                                  myAlgo['url'],
                                  myAlgo['image'],
                                  myAlgo['desc'],
                                )));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Hero(
                          tag: myAlgo['id'],
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width * 0.23,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    myAlgo['image'],
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.65,
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 5),
                              child: Text(
                                myAlgo['name'],
                                style: TextStyle(
                                  fontSize: 15.5,
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.67,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Text(
                                myAlgo['author'],
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    height: 150,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                  ),
                );
              },
            )
          : Center(
              child: SpinKitWave(
                color: Palette.cardBlue,
              ),
            ),
    );
  }
}
