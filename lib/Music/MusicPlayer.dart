import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer audioPlayer;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    initAudio();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Future<void> initAudio() async {
    await audioPlayer.play(
      'https://firebasestorage.googleapis.com/v0/b/anime-wallpaper-9b6b3.appspot.com/o/Memory.mp3?alt=media&token=89d887ff-78a5-426c-b546-1c2af490846a',
      isLocal: false,
      volume: 1.0,
    );
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    await audioPlayer.onPlayerCompletion;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: initAudio,
                child: Text('play'),
              ),
              TextButton(
                onPressed: pauseAudio,
                child: Text('pause'),
              ),
              TextButton(
                onPressed: stopAudio,
                child: Text('stop'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class Music {
//   static initAudio() async {
//     AudioPlayer _audioPlayer = AudioPlayer();
//     await _audioPlayer.play(
//       'https://firebasestorage.googleapis.com/v0/b/anime-wallpaper-9b6b3.appspot.com/o/Memory.mp3?alt=media&token=89d887ff-78a5-426c-b546-1c2af490846a',
//       isLocal: false,
//     );
//   }

//   static pauseAudio() async {
//     AudioPlayer _audioPlayer = AudioPlayer();
//     await _audioPlayer.pause();
//   }

//   static stopAudio() async {
//     AudioPlayer _audioPlayer = AudioPlayer();
//     await _audioPlayer.stop();
//   }
// }
