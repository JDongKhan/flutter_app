import 'package:flutter_app_component/demo/sports/home/widget/sports_list_player.dart';

/// @author jd

PlayerManaer playerManaer = PlayerManaer();

class PlayerManaer {
  SportsListPlayerController sportsListPlayerController;
  void to(SportsListPlayerController playerController) {
    try {
      if (sportsListPlayerController != null) {
        sportsListPlayerController.pause();
        sportsListPlayerController.reset();
      }
    } catch (e) {
      print(e.toString());
    }
    sportsListPlayerController = playerController;
    sportsListPlayerController.play();
  }
}
