import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../core/utils/youtubeController.dart';

class FayoumVedio extends StatelessWidget {
  FayoumVedio({super.key});

  YoutubePlayerController controller = YoutubeControllerSingleton.youtubeController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2608,
      width: MediaQuery.of(context).size.width,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          controller: controller,
          onReady: () {
            //_controller.fitHeight(Size.fromHeight(MediaQuery.of(context).size.height*0.2608));
            //_controller.fitWidth(Size.fromWidth(MediaQuery.of(context).size.width));
          },
          onEnded: (data) {
            controller
                .seekTo(Duration.zero); // Stop the player when the video ends
            controller.pause();
          },
          showVideoProgressIndicator: true,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                  playedColor: Color.fromARGB(255, 107, 161, 131),
                  handleColor: Color.fromARGB(255, 27, 70, 29)),
            ),
            const PlaybackSpeedButton(),
          ],
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
            ],
          );
        },
      ),
    );
  }
}
