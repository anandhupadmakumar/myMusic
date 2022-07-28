import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class MusicSlider extends StatefulWidget {
//   AssetsAudioPlayer assetsAudioPlayer;
//   RealtimePlayingInfos realtimePlayingInfos;
//   MusicSlider(
//       {Key? key,
//       required this.assetsAudioPlayer,
//       required this.realtimePlayingInfos})
//       : super(key: key);

//   @override
//   State<MusicSlider> createState() => _MusicSliderState();
// }

// class _MusicSliderState extends State<MusicSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return SliderTheme(
//         data: SliderThemeData(
//             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.8),
//             trackShape: Customshape()),
//         child: Slider.adaptive(
//             value: widget.realtimePlayingInfos.currentPosition.inSeconds
//                 .toDouble(),
//             max: widget.realtimePlayingInfos.duration.inSeconds.toDouble(),
//             onChanged: (value) {
//               setState(() {
//                   widget.assetsAudioPlayer.seek(Duration(seconds: value.toInt()));

//               print(value);
                
//               });
            
//             }));
//   }
// }
Widget realslider(RealtimePlayingInfos realtimePlayingInfos,
    AssetsAudioPlayer assetAudioPlayer) {
  return SliderTheme(
      data: SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.8),
          trackShape: Customshape()),
      child: Slider.adaptive(
          autofocus: true,
          value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
          min: 0,
          max: realtimePlayingInfos.duration.inSeconds.toDouble(),
          onChanged: (value) {

            assetAudioPlayer.seek(Duration(seconds: value.toInt()));
          }));
}

class Customshape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    @required RenderBox? parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme!.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox!.size.height - trackHeight) / 2;
    final double trackwidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackwidth, trackHeight);
  }
}
