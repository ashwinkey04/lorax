import 'package:flutter/material.dart';
import 'package:lorax/animations/fade_animation.dart';

class TreesEmptyState extends StatelessWidget {
  const TreesEmptyState({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      .5,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/tree.png',
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            'No Tree Added yet',
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, letterSpacing: 1.2),
          )
        ],
      ),
    );
  }
}
