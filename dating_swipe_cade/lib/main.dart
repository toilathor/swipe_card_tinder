import 'dart:math';

import 'package:dating_swipe_cade/user.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Thử vuốt', home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: SwipeCardsView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(label: '', icon: Icon(Icons.cancel)),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: '')
        ],
      ),
    );
  }
}

final List<User> userList = [
  User(image: AssetImage("assets/images/profile1.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile2.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile3.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile4.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile5.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile6.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile7.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile8.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile9.jpg"), age: 1, name: ''),
  User(image: AssetImage("assets/images/profile10.jpg"), age: 1, name: ''),
];

class SwipeCardsView extends StatefulWidget {
  @override
  _SwipeCardsViewState createState() => _SwipeCardsViewState();
}

class _SwipeCardsViewState extends State<SwipeCardsView> {
  List<Widget> widgetList = [];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        var maxHeight = constraints.maxHeight;
        var maxWidth = constraints.maxWidth;

        return Stack(
          children: widgetList = buildCardList(
              maxWidth, maxHeight, screenWidth, screenHeight, reloadUI),
        );
      },
    );
  }

  List<Widget> buildCardList(double maxWidth, double maxHeight,
      double screenWidth, double screenHeight, Function() reloadUI) {
    widgetList = [];
    for (int i = 0; i < userList.length; i++) {
      widgetList.add(ProfileCard(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        i: i,
        user: userList[i],
        previousProfile: widgetList.length >= 1 ? widgetList[i - 1] : null,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        reloadUI: reloadUI,
      ));
    }
    return widgetList;
  }

  reloadUI() {
    setState(() {});
  }
}

// ignore: must_be_immutable
class ProfileCard extends StatefulWidget {
  final screenWidth;
  final screenHeight;
  final i;
  final User user;
  final previousProfile;
  var maxHeight;
  var maxWidth;
  _ProfileCardState? state;
  final reloadUI;

  ProfileCard(
      {this.screenWidth,
      this.screenHeight,
      this.i,
      required this.user,
      this.previousProfile,
      this.maxHeight,
      this.maxWidth,
      this.reloadUI});

  @override
  _ProfileCardState createState() => this.state = _ProfileCardState();

  void refresh() {
    this.state?.refresh();
  }
}

bool isPreviousNowOnForeground = false;

class _ProfileCardState extends State<ProfileCard> {
  double posX = 0, posY = 0;
  Direction dragDirection = Direction.NONE;
  double angleDegree = 0.0;
  var ratioX = 0.0;
  var ratioY = 0.0;
  double scale = 0.97;
  bool isMoving = false;
  double isDraggingFrom = 0;
  late Offset initialPosition;
  var boundToSwipe = 0.25;

  // vị trí hướng đi cũ
  Offset oldPositionForDirection = Offset.zero;

  @override
  Widget build(BuildContext context) {
    var centerOffset = Offset(widget.maxWidth / 2, widget.maxWidth / 2);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: GestureDetector(
        onPanStart: (details) {
          _onPanStart(details);
        },
        onPanEnd: (details) {
          _onPanEnd();
        },
        onPanCancel: () {
          _onPanCancel();
        },
        onPanUpdate: (details) {
          _onPanUpdate(details);
        },
        child: AnimatedContainer(
          //set vị trí của thẻ được dịch đi
          transform: Matrix4.identity()
            ..translate(posX, posY, 0)
            ..rotateDegrees(angleDegree, origin: centerOffset)
            ..scaleWithOrigin(
                widget.i == userList.length - 1 ||
                        (widget.i == userList.length - 2 &&
                            isPreviousNowOnForeground)
                    ? 1
                    : (95 + (5 * ratioX.abs().clamp(0.0, 1.0))) / 100,
                origin: centerOffset),
          //ngưỡng di chuyển
          duration: Duration(milliseconds: isMoving ? 0 : 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 4.0,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    spreadRadius: 0),
              ],
              borderRadius: BorderRadius.circular(20.0),
              image:
                  DecorationImage(fit: BoxFit.cover, image: widget.user.image)),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void _onPanStart(DragStartDetails details) {
    isMoving = true;
    isDraggingFrom = details.localPosition.dy > (widget.maxHeight / 2) ? -1 : 1;
    initialPosition = details.localPosition;
  }

  void _onPanEnd() {
    var hasSwipe = false;

    // Nếu ngưỡng vuốt lớn hơn boundToSwipe thì nó sẽ bay đi
    if (ratioX > -boundToSwipe && dragDirection == Direction.RIGHT) {
      //vuốt phải
      hasSwipe = true;
      posX = 2.0 * widget.screenWidth;
    } else if (ratioX < boundToSwipe && dragDirection == Direction.LEFT) {
      hasSwipe = true;
      posX = (-2.0) * widget.screenWidth;
    } else if (ratioY < -boundToSwipe && dragDirection == Direction.UP) {
      hasSwipe = true;
      posY = -widget.screenHeight;
    } else {
      _onPanCancel();
    }

    if (hasSwipe) {
      setState(() {
        isPreviousNowOnForeground = true;
        isMoving = false;
      });
      widget.previousProfile?.refresh();
      Future.delayed(Duration(milliseconds: 200), () {
        userList.removeAt(userList.length - 1);
        userList.insert(
            0,
            User(
                image: NetworkImage(
                    "https://picsum.photos/2000/3000?random=${Random().nextInt(10000)}")));
        resetValues();
        this.widget.reloadUI();
      });
    }
  }

  void _onPanCancel() {
    setState(() {
      resetValues();
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      posX += details.delta.dx;
      posY += details.delta.dy;
      isMoving = false;
      //kiểm tra vuốt trái hay vuốt phải
      var directionX = offsetDelta(details.localPosition).dx < 0 ? -1 : 1;
      //Góc xoay
      ratioX = offsetDelta(details.localPosition).dx / widget.screenWidth;
      ratioY = offsetDelta(details.localPosition).dy / widget.screenHeight;
      angleDegree = isDraggingFrom * directionX * ratioX.abs() * 30;
    });

    widget.previousProfile?.refresh();

    _computerDargDirection(details);
  }

  void resetValues() {
    posX = 0;
    posY = 0;
    isMoving = false;
    ratioX = 0;
    ratioY = 0;
    dragDirection = Direction.NONE;
    oldPositionForDirection = Offset.zero;
    angleDegree = 0.0;
  }

  Offset offsetDelta(Offset currentPosition) {
    return currentPosition - initialPosition;
  }

  void _computerDargDirection(DragUpdateDetails details) {
    Offset localPosition = details.localPosition;
    if (localPosition.dy < oldPositionForDirection.dy) {
      dragDirection = Direction.UP;
    } else if (localPosition.dy > oldPositionForDirection.dy) {
      dragDirection = Direction.DOWN;
    }

    if (localPosition.dx < oldPositionForDirection.dx) {
      if ((localPosition.dx - oldPositionForDirection.dx).abs() >
          (localPosition.dy - oldPositionForDirection.dy).abs()) {
        dragDirection = Direction.LEFT;
      }
    } else if (localPosition.dx > oldPositionForDirection.dx) {
      if ((localPosition.dx - oldPositionForDirection.dx).abs() >
          (localPosition.dy - oldPositionForDirection.dy).abs()) {
        dragDirection = Direction.RIGHT;
      }
    }

    oldPositionForDirection = localPosition;
  }
}
enum Direction { NONE, LEFT, RIGHT, UP, DOWN }
