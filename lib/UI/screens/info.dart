import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:note_it/UI/privacy.dart';
import 'package:note_it/UI/sidemenu.dart';
import 'package:note_it/UI/terms.dart';
import 'package:note_it/config/palette.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SideMenu(),
      ),
      appBar: AppBar(
        backgroundColor: Palette.scaffold,
        iconTheme: IconThemeData(color: Palette.darkblue),
        title: Text(
          'Info',
          style: TextStyle(
              fontSize: 23,
              color: Palette.darkblue,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'GitHub',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.darkblue,
                ),
              ),
              leading: Icon(
                MdiIcons.github,
                size: 30,
              ),
              onTap: () async {
                const url = 'https://github.com/SamwitAdhikary';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Terms and Condition',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.darkblue,
                ),
              ),
              leading: Icon(
                MdiIcons.pen,
                size: 30,
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Terms()));
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.darkblue,
                ),
              ),
              leading: Icon(
                MdiIcons.note,
                size: 30,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Privacy()));
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Share this app',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.darkblue,
                ),
              ),
              leading: Icon(
                Icons.share,
                size: 30,
              ),
              onTap: () => Share.share(
                  'Hey check out this awesome app. \n bit.ly/NoteItBookApps'),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
