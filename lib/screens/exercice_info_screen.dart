import 'package:fitgoal_app/models/models.dart';
import 'package:fitgoal_app/utils/utils.dart';
import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciceInfo extends StatefulWidget {
  final bool? isFromSession;
  const ExerciceInfo({super.key, this.isFromSession});

  @override
  _ExerciceInfo createState() => _ExerciceInfo();
}

class _ExerciceInfo extends State<ExerciceInfo> {
  String _name = '';
  String _description = '';
  String _image = '';
  String _video = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Exercice exercice = ModalRoute.of(context)?.settings.arguments as Exercice;
    setState(() {
      _name = exercice.name;
      _description = exercice.description;
      _image = exercice.image;
      _video = exercice.video ?? '';
      _controller.load(YoutubePlayer.convertUrlToId(_video) ?? '');
    });
    print("video" + _video);
    return Scaffold(
      appBar: reducedAppBar(context, 'exercices'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _imageLocation(exercice),
            const SizedBox(height: 20),
            _exerciceName(context),
            const SizedBox(height: 20),
            _descriptionBox(context)
          ],
        ),
      ),
    );
  }

  Widget _imageLocation(Exercice e) {
    return Container(width: 300, height: 300, child: _carousel(e));
  }

  Widget _exerciceName(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          _name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _descriptionBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          _description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _carousel(Exercice e) {
    print("longitud carousel" + _video);
    return CarouselSlider.builder(
      itemCount: _video == '' ? 1 : 2,
      itemBuilder: (ctx, index, realIdx) {
        if (index == 0) {
          return FadeInImage(
            placeholder: const AssetImage('assets/gif/loading.gif'),
            image: MemoryImage(utils.dataFromBase64String(_image)),
            fit: BoxFit.cover,
          );
        } else {
          return YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            onReady: () {
              _controller.load(YoutubePlayer.convertUrlToId(_video) ?? '');
            },
          );
        }
      },
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        aspectRatio: 1.5,
      ),
    );
  }
}
