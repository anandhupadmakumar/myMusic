import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_sample/play_operations/play_pause.dart';
import 'package:music_sample/screens/home_screen.dart';

class MpDrawer extends StatefulWidget {
  AssetsAudioPlayer audioPlayer;
  bool value = false;
  MpDrawer({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  State<MpDrawer> createState() => _MpDrawerState();
}

class _MpDrawerState extends State<MpDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(91, 11, 185, 234),
      child: SafeArea(
        child: InkWell(
            child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
                onTap: () {
                  //share bottomsheet or some page navigation
                },
                leading: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                title: Text(
                  'Share',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )),
            ListTile(
              leading: Icon(
                Icons.notifications_none,
                color: Colors.white,
              ),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: Switch(
                  value: widget.value,
                  onChanged: (bool newValue) {
                    setState(() {
                      widget.value = newValue;
                      widget.audioPlayer.showNotification = newValue;


                      // play(widget.audio, widget.value);
                    });

                    //set state switch value
                  }),
            ),
            ListTile(
              onTap: () {
                //rate us
              },
              leading: Icon(
                Icons.star_border_purple500_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Rate Us',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                //privacy page
              },
              leading: Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              title: Text(
                'Privacy policy',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                //about page navigation
              },
              leading: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              title: Text(
                'About',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                //exit from the app
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text(
                'Exit',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Text(
                'version 1.0.0',
                style: TextStyle(color: Color.fromARGB(255, 232, 239, 11)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )),
      ),
    );
  }
}

Widget drawerHome(context, value) {
  return Drawer(
    backgroundColor: const Color.fromARGB(91, 11, 185, 234),
    child: SafeArea(
      child: InkWell(
          child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
              onTap: () {
                //share bottomsheet or some page navigation
              },
              leading: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: Text(
                'Share',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )),
          ListTile(
            leading: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            title: Text(
              'Notification',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            trailing: Switch(
                value: value,
                onChanged: (bool newValue) {
                  value = newValue;
                  //set state switch value
                }),
          ),
          ListTile(
            onTap: () {
              //rate us
            },
            leading: Icon(
              Icons.star_border_purple500_outlined,
              color: Colors.white,
            ),
            title: Text(
              'Rate Us',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () {
              //privacy page
            },
            leading: Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
            title: Text(
              'Privacy policy',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () {
              //about page navigation
            },
            leading: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            title: Text(
              'About',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () {
              //exit from the app
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'Exit',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: Text(
              'version 1.0.0',
              style: TextStyle(color: Color.fromARGB(255, 232, 239, 11)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    ),
  );
}
