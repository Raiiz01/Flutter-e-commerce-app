import 'package:flutter/material.dart';

class ChipWidget extends StatefulWidget {
  ChipWidget({
    super.key,
    required this.ChipLable,
    required this.avatar,
  });

final String ChipLable;
final  avatar;

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(2),
      child: Chip(
        avatar: widget.avatar,
        label: Text(widget.ChipLable),),
    );
  }
}