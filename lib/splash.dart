import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:ymgk_lessons_project/question_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
    openMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("MERHABA OYUNCAK DÜKKANINA HOŞGELDİNİZ...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => QuestionView(assetsAudioPlayer: assetsAudioPlayer)), (route) => false);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: const Center(child: Text("HAYDİ İÇERİ GİRELİM")),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/questions/answer.png"))),
              // child: Text("Hoş geldiniz"),
            ),
          )
        ],
      ),
    );
  }

  void openMusic() async {
    await assetsAudioPlayer.open(Audio("assets/mp3/app_music.mp3"), showNotification: false, volume: 2, loopMode: LoopMode.playlist);
  }
}
