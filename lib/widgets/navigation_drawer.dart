import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:heza/play_operations/play_pause.dart';
import 'package:heza/screens/home_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

import '../screens/home_screen_duplicate.dart';

class MpDrawer extends StatefulWidget {
  AssetsAudioPlayer audioPlayer;
  bool value = false;
  MpDrawer({Key? key, required this.audioPlayer, required value})
      : super(key: key);

  @override
  State<MpDrawer> createState() => _MpDrawerState();
}

class _MpDrawerState extends State<MpDrawer> {
  late String _appName;
  late String _packageName;
  late String _version;
  late String _buildNumber;
  bool isloading = true;
  double rating = 0;

  void applicationinfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;

    isloading = false;
    setState(() {});
  }

  Widget buildRating() {
    return RatingBar.builder(
      allowHalfRating: true,
      initialRating: rating,
      updateOnDrag: true,
      minRating: 0.5,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          this.rating = rating;
        });
      },
    );
  }

  void RatingShowDialog(ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: Text('Rting sample'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave a star rating'),
                const SizedBox(
                  height: 20,
                ),
                buildRating(),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Drawer(
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
                      onTap: () async {
                        await Share.share('My music app');

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
                        value: notification == null || notification == true
                            ? true
                            : false,
                        onChanged: (bool newValue) {
                          setState(() {
                            notification = newValue;
                            audioPlayer.showNotification = newValue;

                            // play(widget.audio, widget.value);
                          });

                          //set state switch value
                        }),
                  ),
                  ListTile(
                      onTap: () {
                        RatingShowDialog(context);
                        //rate us
                      },
                      leading: const Icon(
                        Icons.star_border_purple500_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Rate Us',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      trailing: Text(
                        '$rating',
                        style: TextStyle(color: Colors.yellow),
                      )),
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
                      showAboutDialog(
                        context: context,
                        applicationName: _appName,
                        applicationVersion: _version,
                      );

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
                      applicationExit(context);
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
                      _version,
                      style:
                          TextStyle(color: Color.fromARGB(255, 232, 239, 11)),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )),
            ),
          );
  }

  @override
  void initState() {
    applicationinfo();
    // TODO: implement initState
    super.initState();
  }
}

// PackageInfo packageInfo = PackageInfo(
//     appName: 'music_sample',
//     packageName: 'packageName',
//     version: 'version: 1.0.0+1',
//     buildNumber: 'buildNumber');

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
              'appname!',
              style: TextStyle(color: Color.fromARGB(255, 232, 239, 11)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    ),
  );
}

void applicationExit(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to exit'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes'))
          ],
        );
      });
}
