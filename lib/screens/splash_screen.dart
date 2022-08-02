import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_sample/db_functions/db_crud_function.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';

import 'package:permission_handler/permission_handler.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Map<dynamic, dynamic> a = {};
List<String> allAudios = [];
List<String> allAudio = [];
List<String> dbSongs = [];
List<Audio> finalSongList = [];
List<String> mTitle = [];
List<String> mPath = [];
List<String> mArtist = [];
List<String> malbum = [];
List<String> malbumImage = [];
List<String> mDuration = [];

class _SplashScreenState extends State<SplashScreen> {
  List<String>? allAudios;
  List<Audio>? secondAllaudios;
  static const _platform = MethodChannel('search_files_in_storage/search');
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/images/music-logo-recording-studio-emblem-equalizer-vector-19934456.jpg'),
        )),
      ),
    );
  }

  void searchInStorage() {
    _platform.invokeMethod('search').then((value) {
      final _res = value as Map<Object?, Object?>;
      log('res 1 ${_res.toString()}');
      log('res2 valueeeeeeeee  ${value}');

      onSuccess(_res);
    }).onError((error, stackTrace) {
      log(error.toString());

      print(onSuccess);
    });
  }

  void convertingFromMap(value) {
    final tempTitle = value['title'] as List<Object?>;
    log('aaaaaaaaaanandhuannnn $tempTitle');
    mTitle = tempTitle.map((e) => e.toString()).toList();
    log("........................${mTitle.length}");

    final tempPath = value['path'] as List<Object?>;
    log('aaaaaaaaaanandhuannnn $tempPath');
    mPath = tempPath.map((e) => e.toString()).toList();
    log("........................${mPath.length}");

    final tempArtist = value['artist'] as List<Object?>;
    log('aaaaaaaaaanandhuannnn $tempTitle');
    mArtist = tempArtist.map((e) => e.toString()).toList();
    log("........................$mArtist");
    log("........................${mArtist.length}");

    final tempAlbum = value['album'] as List<Object?>;
    log('aaaaaaaaaanandhuannnn $tempAlbum');
    malbum = tempAlbum.map((e) => e.toString()).toList();
    log("..................albumMMMMM......$malbum");
    log("........................${mArtist.length}");
    final tempAlbumImage = value['image'] as List<Object?>;
    log('aaaaaaaaaanandhuannnn $tempTitle');
    malbumImage = tempAlbumImage.map((e) => e.toString()).toList();
    log("........................$malbumImage");
    log("........................${malbumImage.length}");
    final mDurationtemp = value['duration'] as List<Object?>;
    List<String> mDurationtemp2 =
        mDurationtemp.map((e) => e.toString()).toList();
    log("........................$malbumImage");
    log("........................${malbumImage.length}");
    List<int> durationtemp = mDurationtemp2.map((e) => int.parse(e)).toList();

    for (var i = 0; i < mDurationtemp.length; i++) {
      String mDuration1 =
          _printDuration(Duration(milliseconds: durationtemp[i]));
      mDuration.add(mDuration1);
    }
    log('durationnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${mDuration.toString()}');
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future splashFetch() async {
    log('requst permission');
    if (await _requestPermission(Permission.storage)) {
      searchInStorage();

      mSplash();
    } else {
      splashFetch();
    }
  }

  // fetchAudiosFromStorage() async {
  //   List<String> query = [".mp3"];
  //   searchInStorage(query, onSuccess, (p0) {});
  // }

  Future<bool> _requestPermission(Permission isPermission) async {
    const store = Permission.storage;
    const access = Permission.accessMediaLocation;

    if (await isPermission.isGranted) {
      await access.isGranted && await store.isGranted;
      log('permission granted');
      return true;
    } else {
      print('object');
      var result = await store.request();
      print('result $result');
      var oneresult = await access.request();
      log('permission request ');

      if (result == PermissionStatus.limited &&
          oneresult == PermissionStatus.limited) {
        log('permission status granted ');

        return true;
      } else {
        log('permission denied ');

        return false;
      }
      // }

      // Future<void> _getDocuments() async {
      //   MethodChannel _methodChannel =
      //       MethodChannel('search_files_in_storage/search');
      //   List<dynamic> documentList = [""];
      //   try {
      //     documentList = await _methodChannel.invokeMethod("Documents");
      //   } on PlatformException catch (e) {
      //     print("exceptiong");
      //   }
      //   documentList.forEach((document) {
      //     print("Document: $document"); // seach in Logcat "Document"
      //   });
    }
  }

  @override
  void initState() {
    // play(assetsAudioPlayer);
    splashFetch();
    print('started');

    // TODO: implement initState
    super.initState();
  }

  Future<void> mSplash() async {
    await Future.delayed(Duration(seconds: 5));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => HomeScreen()),
    );
  }

  onSuccess(audioListFromStorage) async {
    convertingFromMap(audioListFromStorage);
    final data = MusicModel(id: 0,
        title: mTitle, path: mPath, album: malbum, duration: mDuration,);
    await addMusicList(data);
    log('db for data..............??????????????$data');
    await getAllMusicList();

    setState(() {
      // allAudios = allAudio;

      // a = [Audio(allVideos.toString())];
    });

    // final data = MusicModel(
    //   path: allAudios,
    // );
    // // addMusicList(data);
    // log('db for data..............??????????????$data');

    //   await getAllStudentDetails();
    //   dbSongs = musicValueNotifier.value[1].path!;

    for (var i = 0; i < mPath.length; i++) {
      finalSongList.add(Audio.file(musicValueNotifier.value[0].path[i],
          metas: Metas(
            title: musicValueNotifier.value[0].title[i],
            artist: musicValueNotifier.value[0].album[i],
          )));
      log('inside for loop ................${finalSongList.toString()}');
    }

    //   log('allvideos ${dbSongs.toString()}');
    //   // log('an${a.toString()}');
    // }
  }
}
