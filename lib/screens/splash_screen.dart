import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_sample/db_functions/db_crud_function.dart';
import 'package:music_sample/db_functions/music_modal_class.dart';
import 'package:path/path.dart';

import 'package:permission_handler/permission_handler.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<MusicModel> allAudios = [];
List<String> allAudio = [];
List<String> dbSongs = [];
List<Audio> finalSongList = [];

class _SplashScreenState extends State<SplashScreen> {
  List<String>? allAudios;
  List<Audio>? secondAllaudios;
  static const _platform = MethodChannel('search_files_in_storage/search');
  bool value = false;
  @override
  Widget build(BuildContext context) {
    mSplash(context);
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

  void searchInStorage(
    List<String> query,
    void Function(List<String>) onSuccess,
    void Function(String) onError,
  ) {
    _platform.invokeMethod('search', query).then((value) {
      final _res = value as List<Object?>;
      log('res 1 ${_res.toString()}');

      setState(() {
        // a = [Audio(_res[1].toString())];
      });

      onSuccess(allAudios = _res.map((e) => e.toString()).toList());
    }).onError((error, stackTrace) {
      log(error.toString());
      onError(error.toString());
      print(onError);
      print(onSuccess);
    });
  }

  Future splashFetch() async {
    log('requst permission');
    if (await _requestPermission(Permission.storage)) {
      searchInStorage([
        '.mp3',
      ], onSuccess, (p0) {});
    } else {
      splashFetch();
    }
  }

  // fetchAudiosFromStorage() async {
  //   List<String> query = [".mp3"];
  //   searchInStorage(query, onSuccess, (p0) {});
  // }

  Directory? dir;

  Future<bool> _requestPermission(Permission isPermission) async {
    const store = Permission.storage;
    const access = Permission.accessMediaLocation;

    if (await isPermission.isGranted) {
      await access.isGranted && await access.isGranted;
      log('permission granted ');
      return true;
    } else {
      var result = await store.request();
      var oneresult = await access.request();
      log('permission request ');

      if (result == PermissionStatus.granted &&
          oneresult == PermissionStatus.granted) {
        log('permission status granted ');

        return true;
      } else {
        log('permission denied ');

        return false;
      }
    }

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
    // }
  }

  @override
  void initState() {
    // play(assetsAudioPlayer);
    splashFetch();
    print('started');

    // TODO: implement initState
    super.initState();
  }

  Future<void> mSplash( context) async {
    await Future.delayed(Duration(seconds: 5));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (ctx) => HomeScreen(
                
              )),
    );
  }

  onSuccess(List<String> audioListFromStorage) async {
    allAudio = audioListFromStorage;
    allAudio.sort((a, b) {
      return a.split("/").last.compareTo(b.split("/").last);
    });

    setState(() {
      // allAudios = allAudio;

      log('aaaaaaaaaaaaaaaaaaaaaaaaaaa${allAudios.toString()}');

      // a = [Audio(allVideos.toString())];
    });
   

    final data = MusicModel(path: allAudios,
    );
    addMusicList(data);
    log('db for data..............??????????????$data');

    await getAllStudentDetails();
    dbSongs = musicValueNotifier.value[1].path!;

    for (var i = 0; i < dbSongs.length; i++) {
      finalSongList.add(Audio.file(
        dbSongs[i],
        metas: Metas(
          title:basename(musicValueNotifier
                                              .value[1].path![i]
                                              .toString()),

        ),
       
      ));
      log('inside for loop ................${finalSongList.toString()}');
    }

    log('allvideos ${dbSongs.toString()}');
    // log('an${a.toString()}');
  }
}
