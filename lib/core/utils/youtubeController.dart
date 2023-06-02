import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'constance/strings_manager.dart';

class YoutubeControllerSingleton {
  static YoutubePlayerController? _youtubeController;

  static YoutubePlayerController get youtubeController {
    _youtubeController ??= YoutubePlayerController(
      initialVideoId: AppStrings.initialVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false,
        forceHD: true,
      ),
    );
    return _youtubeController!;
  }
}
