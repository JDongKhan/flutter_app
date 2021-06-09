import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/style_card/style_card.dart';
import 'package:jd_core/jd_core.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

/// @author jd

class StackedCardDemo extends StatefulWidget {
  @override
  _StackedCardDemoState createState() => _StackedCardDemoState();
}

class _StackedCardDemoState extends State<StackedCardDemo> {
  final List<Widget> styleCards = [
    StyleCard(
      image: Image.asset(JDAssetBundle.getImgPath('ali_connors')),
      title: 'Team Leader',
      description:
          'It play extremely important role in motivating\nour team adn ensuring their success.',
    ),
    StyleCard(
      image: Image.asset(JDAssetBundle.getImgPath('ali_connors')),
      title: 'Team Leader',
      description:
          'It play extremely important role in motivating\nour team adn ensuring their success.',
    ),
    StyleCard(
      image: Image.asset(JDAssetBundle.getImgPath('ali_connors')),
      title: 'Team Leader',
      description:
          'It play extremely important role in motivating\nour team adn ensuring their success.',
    ),
    StyleCard(
      image: Image.asset(JDAssetBundle.getImgPath('ali_connors')),
      title: 'Team Leader',
      description:
          'It play extremely important role in motivating\nour team adn ensuring their success.',
    ),
    StyleCard(
      image: Image.asset(JDAssetBundle.getImgPath('ali_connors')),
      title: 'Team Leader',
      description:
          'It play extremely important role in motivating\nour team adn ensuring their success.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StackedCard Demo'),
      ),
      body: StackedCardCarousel(
        initialOffset: 40,
        spaceBetweenItems: 400,
        items: styleCards,
      ),
    );
  }
}
