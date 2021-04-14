import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_it/UI/openbook.dart';
import 'package:http/http.dart' as http;
import 'package:note_it/config/palette.dart';

class CppScreen extends StatefulWidget {
  @override
  _CppScreenState createState() => _CppScreenState();
}

class _CppScreenState extends State<CppScreen> {
  final String url = 'https://samwitadhikary.github.io/jsons/cpp.json';
  List data;

  @override
  void initState() {
    super.initState();
    fetchCpp();
  }

  fetchCpp() async {
    var response = await http.get(Uri.parse(url));
    if (!mounted) return;
    setState(() {
      var convertJson = json.decode(response.body);
      data = convertJson['cpp'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: data != null
            ? ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final mycpp = data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpenBook(
                                  mycpp['name'],
                                  mycpp['author'],
                                  mycpp['tagline'],
                                  mycpp['url'],
                                  mycpp['image'],
                                  mycpp['desc'])));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width * 0.23,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        mycpp['image']),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.65,
                                margin: EdgeInsets.fromLTRB(0, 10, 10, 5),
                                child: Text(
                                  mycpp['name'],
                                  style: TextStyle(
                                    fontSize: 15.5,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.67,
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text(
                                  mycpp['author'],
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
      ),
    );
  }
}
