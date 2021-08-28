import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_it/UI/downloadpdf.dart';
import 'package:note_it/UI/sidemenu.dart';
import 'package:note_it/config/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  String directory;
  List file = [];

  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  _listofFiles() async {
    directory = (await getExternalStorageDirectory()).path;
    print(directory);
    setState(() {
      file = io.Directory(directory).listSync();
      // print(file);
    });
  }

  deleteFile(File file) {
    file.deleteSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SideMenu(),
      ),
      appBar: AppBar(
        title: Text(
          'Downloads',
          style: TextStyle(
              color: Palette.darkblue,
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Palette.scaffold,
        iconTheme: IconThemeData(color: Palette.darkblue),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: file.length,
                itemBuilder: (BuildContext context, int index) {
                  String path = file[index].path;
                  String pathDir = path
                      .replaceAll(
                          "/storage/emulated/0/Android/data/com.samwit.note_it/files/",
                          "")
                      .replaceAll(".pdf", "");
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) {
                      deleteFile(File(path));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("$pathDir deleted")));
                    },
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Align(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DownloadPDF(path, pathDir)));
                      },
                      child: ListTile(
                        title: Text(pathDir),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
