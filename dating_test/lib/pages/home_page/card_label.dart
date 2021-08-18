import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardLabel extends StatelessWidget {
  final SvgPicture image;
  final Color color;

  CardLabel({required this.image, required this.color});

  factory CardLabel.like() {
    return CardLabel(
      image: SvgPicture.asset("assets/home/like_in_card.svg"),
      color: Color.fromARGB(255, 233, 64, 87),
    );
  }

  factory CardLabel.dislike() {
    return CardLabel(
      image: SvgPicture.asset("assets/home/dislike_in_card.svg"),
      color: Color.fromARGB(255, 242, 113, 33),
    );
  }

  factory CardLabel.superLike() {
    return CardLabel(
      image: SvgPicture.asset("assets/home/super_like_in_card.svg"),
      color: Color.fromARGB(255, 138, 35, 135),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Container(
        child: image,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(80.0),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                offset: Offset(0.0, 1.0),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ]),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80.0),
      ),
    );
  }
}
