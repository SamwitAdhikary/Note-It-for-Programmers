import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:note_it/UI/viewpdf.dart';
import 'package:note_it/config/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OpenBook extends StatefulWidget {
  final int id;
  final String name;
  final String author;
  final String tagline;
  final String url;
  final String image;
  final String desc;
  OpenBook(this.id, this.name, this.author, this.tagline, this.url, this.image,
      this.desc);

  @override
  _OpenBookState createState() =>
      _OpenBookState(id, name, author, tagline, url, image, desc);
}

class _OpenBookState extends State<OpenBook> {
  final int id;
  final String name;
  final String author;
  final String tagline;
  final String url;
  final String image;
  final String desc;
  _OpenBookState(this.id, this.name, this.author, this.tagline, this.url,
      this.image, this.desc);

  bool downloading = false;
  var progressString = "";

  Future<void> downloadFile() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      Dio dio = Dio();

      try {
        final dir = await getExternalStorageDirectory();
        await dio.download(url, "${dir.path}/$name.pdf",
            onReceiveProgress: (rec, total) {
          setState(() {
            downloading = true;
            progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
        });
      } catch (e) {
        print(e);
      }
      setState(() {
        downloading = false;
        progressString = "Completed";
      });
      print('Completed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: Palette.darkblue),
        ),
        actions: [
          downloading == false
              ? IconButton(
                  icon: Icon(MdiIcons.download),
                  onPressed: () {
                    downloadFile();
                  },
                  
                )
              : Offstage()
        ],
        backgroundColor: Palette.scaffold,
        elevation: 0,
        iconTheme: IconThemeData(color: Palette.darkblue),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Palette.darkblue.withOpacity(0.999),
                      BlendMode.multiply))),
        ),
        Center(
          child: Column(
            children: [
              Hero(
                tag: id,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  height: 340,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
        SlidingUpPanel(
          minHeight: 80,
          backdropEnabled: true,
          panel: Container(
            child: Column(
              children: [
                Container(
                  height: 20,
                  // color: Colors.red,
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 15,
                        color: Colors.grey,
                        height: 5,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 5,
                        color: Colors.grey,
                        width: 30,
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Description :',
                    style: TextStyle(fontSize: 22, color: Palette.darkblue),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 35),
                ),
                Container(
                  height: 270,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListView(physics: BouncingScrollPhysics(), children: [
                    Text(
                      desc,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      backgroundColor:
                          MaterialStateProperty.all(Palette.lightblue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPDF(name, url)));
                  },
                  child: Text(
                    "Read Book",
                    style: TextStyle(fontSize: 21, color: Colors.white),
                  ),
                  // padding: EdgeInsets.all(20),
                  // color: Palette.lightblue,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        downloading
            ? Container(
                decoration: BoxDecoration(color: Colors.black54),
                child: Center(
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 70,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 8,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 30,
                            child: Center(
                              child: Text(
                                'Downloading File $progressString',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Offstage()
      ]),
    );
  }
}
