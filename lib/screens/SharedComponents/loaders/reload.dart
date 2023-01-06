import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';

class Reload extends StatefulWidget {
  final Widget child;
  Future<void> Function() load;

  Reload({Key? key, required this.child, required this.load}) : super(key: key);

  @override
  _ReloadState createState() => _ReloadState();
}

class _ReloadState extends State<Reload> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: mainColor,
      backgroundColor: Colors.white,
      onRefresh: () async {
        widget.load();
      },
      child: widget.child,
    );
  }
}
