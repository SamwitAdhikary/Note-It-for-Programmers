import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:note_it/UI/privacy.dart';
import 'package:note_it/UI/terms.dart';
import 'package:note_it/config/palette.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.scaffold,
        child: ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Text(
            'Hello Programmers!!!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        ),
        Divider(),
        ListTile(
          title: Text(
            'GitHub',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(MdiIcons.github),
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
            'Terms And Condition',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(MdiIcons.pen),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Terms(),
                ));
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(MdiIcons.note),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Privacy(),
                ));
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Share This App',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          trailing: Icon(Icons.share),
          onTap: () => Share.share('Hey check out this awesome app. \n bit.ly/NoteItBookApps'),
        ),
        Divider(),
      ],
    ));
  }
}