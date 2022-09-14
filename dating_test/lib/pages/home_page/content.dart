import 'dart:math';

import 'package:dating_test/models/user.dart';
import 'package:dating_test/pages/home_page/card_label.dart';
import 'package:dating_test/style/my_icons.dart';
import 'package:dating_test/style/values.dart';
import 'package:dating_test/widgets/dating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipable_stack/swipable_stack.dart';

final double _heightBottom = 99.0;

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  SwipableStackController _controller = SwipableStackController();

  void _listenController() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SwipableStack(
          itemCount: 10,
          onWillMoveNext: (index, direction) {
            final allowedActions = [
              SwipeDirection.up,
              SwipeDirection.right,
              SwipeDirection.left,
            ];
            return allowedActions.contains(direction);
          },
          controller: _controller,
          onSwipeCompleted: (index, direction) {},
          overlayBuilder: (context, swipeProperty) {
            final opacity = min(swipeProperty.swipeProgress, 1.0);
            final isRight = swipeProperty.direction == SwipeDirection.right;
            final isLeft = swipeProperty.direction == SwipeDirection.left;
            final isUp = swipeProperty.direction == SwipeDirection.up;
            return Center(
              child: Stack(
                children: [
                  Opacity(
                    opacity: isRight ? opacity : 0,
                    child: CardLabel.like(),
                  ),
                  Opacity(
                    opacity: isLeft ? opacity : 0,
                    child: CardLabel.dislike(),
                  ),
                  Opacity(
                    opacity: isUp ? opacity : 0,
                    child: CardLabel.superLike(),
                  ),
                ],
              ),
            );
          },
          builder: (context, swipeProperty) {
            return Padding(
              padding: EdgeInsets.fromLTRB(40, 124, 40, 140),
              child: Center(
                child: DatingCard(
                  user: User(
                      name: 'toilathor',
                      location: 10,
                      age: 20,
                      job: 'Information Techno',
                      image: '${(swipeProperty.index + 1)}'),
                ),
              ),
            );
          },
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomButton(
                      onPressed: () {
                        //TODO dislike
                        _controller.next(swipeDirection: SwipeDirection.left);
                      },
                      icon: SvgPicture.asset(iconDislike),
                      color: Colors.white,
                      size: _heightBottom * 4 / 5),
                  _BottomButton(
                      onPressed: () {
                        //TODO like
                        _controller.next(swipeDirection: SwipeDirection.right);
                      },
                      icon: SvgPicture.asset(iconLike),
                      color: my_color_pink,
                      size: _heightBottom),
                  _BottomButton(
                      onPressed: () {
                        //TODO Super Like
                        _controller.next(swipeDirection: SwipeDirection.up);
                      },
                      icon: SvgPicture.asset(iconStar),
                      color: Colors.white,
                      size: _heightBottom * 4 / 5),
                ],
              ),
            )),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listenController);
    _controller.dispose();
  }
}

class _BottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final SvgPicture icon;
  final Color color;
  final double size;

  _BottomButton(
      {required this.onPressed,
      required this.icon,
      required this.color,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ElevatedButton(
        onPressed: onPressed,
        child: icon,
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size),
                    )),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color)),
      ),
    );
  }
}
