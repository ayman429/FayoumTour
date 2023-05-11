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
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.235,
      width: MediaQuery.of(context).size.width * 0.92,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                    playedColor: Colors.green, handleColor: Colors.lightGreen),
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
      ),
    );
  }
}
