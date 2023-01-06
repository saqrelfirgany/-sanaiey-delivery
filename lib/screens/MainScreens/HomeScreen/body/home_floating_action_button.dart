import 'package:flutter/cupertino.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';


class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.only(bottom: 50),
      width: width(context) * .9,
      alignment: Alignment.bottomRight,
      child: Container(
        decoration:
            const BoxDecoration(color: mainColor, shape: BoxShape.circle),
        height: 60,
        width: width(context) * .2,
        child: Center(
          child: Container(
            height: 30,
            width: width(context) * .2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/chat.png"),
                    fit: BoxFit.contain)),
          ),
        ),
      ),
    );
  }
}
