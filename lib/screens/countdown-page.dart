import 'package:fitgoal_app/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/round-button.dart';
import 'package:audioplayers/audioplayers.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;
  AudioPlayer? player;
  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progressValue = 0;

  Duration lastDuration = Duration(seconds: 60);

void notify() async {
  if (countText == '0:00:03' && isPlaying) {
    const alarmAudioPath = 'mp3_sounds/end-countdown-sound.mp3';
    await player!.play(AssetSource(alarmAudioPath));
    isPlaying = true;
    player!.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        isPlaying = false;
      }
    });
  }
}





  @override
  void initState() {
    super.initState();
        player =  AudioPlayer();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );
    controller.addListener(
      () {
        notify();
        if (controller.isDismissed) {
          setState(() {
            progressValue = 1.0;
            isPlaying = false;
          });
        } else {
          setState(
            () {
              progressValue = controller.value;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
        backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      backgroundColor: const Color.fromRGBO(114, 191, 1, 1),
                      strokeWidth: 6,
                      value: progressValue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.isDismissed) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 300,
                            child: CupertinoTimerPicker(
                              initialTimerDuration: lastDuration,
                              onTimerDurationChanged: (time) {
                                setState(
                                  () {
                                    controller.duration = time;
                                    lastDuration = time;
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) => Text(
                        countText,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(114, 191, 1, 1)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating == false) {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    } else {
                      controller.stop();
                      setState(
                        () {
                          isPlaying = false;
                        },
                      );
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: RoundButton(
                    icon: Icons.stop,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
