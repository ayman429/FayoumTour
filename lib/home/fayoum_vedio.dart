import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../core/utils/constance/strings_manager.dart';

class FayoumVedio extends StatelessWidget {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: AppStrings.initialVideoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      showLiveFullscreenButton: false,
      forceHD: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2608,
      //width: MediaQuery.of(context).size.width*0.90,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          controller: _controller,
          onReady: () {
            //_controller.fitHeight(Size.fromHeight(MediaQuery.of(context).size.height*0.2608));
            //_controller.fitWidth(Size.fromWidth(MediaQuery.of(context).size.width));
          },
          onEnded: (data) {
            _controller
                .seekTo(Duration.zero); // Stop the player when the video ends
            _controller.pause();
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
