import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'card_img.dart';

class QuestionView extends StatefulWidget {
  final AssetsAudioPlayer assetsAudioPlayer;
  const QuestionView({super.key, required this.assetsAudioPlayer});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  // assetsAudioPlayer = AssetsAudioPlayer();
  String s1 = "assets/questions/soru.png";
  String s1A = "assets/questions/image.png";
  String s1B = "assets/questions/image1.png";
  String s1C = "assets/questions/image2.png";
  String s1D = "assets/questions/image3.png";
  late List<String> s1ListImg;

  late CardImg card1;
  late CardImg card2;
  late CardImg card3;
  late CardImg card4;
  late CardImg card5;
  int? _selectedOptionIndex;
  late CardImg chooseCard;
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
    s1ListImg = [s1A, s1B, s1C, s1D];

    card1 = CardImg(questionPath: s1, answerIndex: 0, imgList: s1ListImg);
    chooseCard = card1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Center(
              child: Text(
                "Hafta başında bir oyuncak mağazasında 60 tane oyuncak bebek , 40 top , 55 robot ve 75 oyuncak ayı vardı. Hafta sonuna kadar, 54 oyuncak bebek, 34 top , 11 robot ve 60 oyuncak ayı satıldı ? EN YÜKSEK ORANDA SATILAN OYUCAK HANGİSİDİR ?",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(children: chooseCard.imgList.asMap().entries.map((e) => buildAnserItems(e.value, e.key)).toList())),
        ],
      ),
    );
  }

  AppBar buildAppar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text('Sorular'),
      actions: [
        IconButton(
          onPressed: () async {
            await onPressed();
          },
          icon: Icon(isOpen ? Icons.music_note : Icons.music_off),
          iconSize: 30,
        ),
        const SizedBox(width: 10)
      ],
    );
  }

  Widget buildAnserItems(String path, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOptionIndex = index;
        });
        if (_selectedOptionIndex == chooseCard.answerIndex) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Tebrikler'),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await widget.assetsAudioPlayer.stop();
                        await widget.assetsAudioPlayer.dispose();
                        exit(0);
                      },
                      child: const Text('Çıkış'),
                    ),
                  ],
                );
              });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Yanlıs!"),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: _selectedOptionIndex == index ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: _selectedOptionIndex == index ? Colors.blue : Colors.grey,
            width: 1.0,
          ),
        ),
        child: Image.asset(path),
      ),
    );
  }

  Future<void> onPressed() async {
    setState(() {
      isOpen = !isOpen;
    });
    if (widget.assetsAudioPlayer.isPlaying.value) {
      await widget.assetsAudioPlayer.pause();
    } else {
      await widget.assetsAudioPlayer.play();
    }
  }
}
