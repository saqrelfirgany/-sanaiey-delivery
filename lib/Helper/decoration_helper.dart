import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class GetShadow1 extends StatelessWidget {
  const GetShadow1({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: child,
    );
  }
}
class GetShadow extends StatelessWidget {
  const GetShadow({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: child,
    );
  }
}

BoxDecoration decorationRadius({Color color = Colors.white,double radius = 10}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius.r),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        offset: const Offset(0, 0),
        blurRadius: 4.0,
      )
    ],
  );
}

BoxDecoration decorationRadiusBorder({
  Color color = const Color(0xFFDFDFDF),
  double width = 1,
}) {
  return decorationRadius().copyWith(
    border: Border.all(width: width, color: color),
  );
}

BoxDecoration decorationDoubleRadiusBorder({
  Color color = const Color(0xFFDFDFDF),
  double radius = 20
}) {
  return decorationRadius().copyWith(
    borderRadius: BorderRadius.circular(radius.r),
    border: Border.all(width: 1, color: color),
  );
}

BoxDecoration decorationDoubleRadius() {
  return decorationRadius().copyWith(
    borderRadius: BorderRadius.circular(20.r),
  );
}

BoxDecoration decorationDoubleRadiusTop() {
  return decorationDoubleRadius().copyWith(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
  );
}

BoxDecoration decorationDoubleRadiusNoShad() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  );
}
