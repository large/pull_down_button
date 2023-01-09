import 'package:cupertino_range_slider_improved/cupertino_range_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pull_down_button.dart';

///Slider for handling
class PullDownMenuItemSlider extends PullDownMenuEntry {
  ///Init slider
  const PullDownMenuItemSlider({
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.minRange,
    required this.maxRange,
    required this.onMinChanged,
    required this.onMaxChanged,
    this.activeColor = CupertinoColors.activeBlue, //Colors defaults
    this.trackColor = const Color(0xFFB5B5B5),
    this.thumbColor = const Color(0xFFFFFFFF),
    super.key,
  });

  ///Here we go
  final String title;
  final double maxRange;
  final double minRange;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onMinChanged;
  final ValueChanged<double> onMaxChanged;
  final Color activeColor;
  final Color trackColor;
  final Color thumbColor;

  @override
  Widget build(BuildContext context) => _Slider(
        maxRange: maxRange,
        minRange: minRange,
        onMinChanged: onMinChanged,
        onMaxChanged: onMaxChanged,
        minValue: minValue,
        maxValue: maxValue,
        title: title,
        activeColor: activeColor,
        trackColor: trackColor,
        thumbColor: thumbColor,
      );

  // Can be ignored
  @override
  double get height => 0;

  // Can be ignored
  @override
  bool get isDestructive => false;

  // Can be ignored
  @override
  bool get represents => false;
}

/// This class has to "wrap" round to the class to be a statefull object
class _Slider extends StatefulWidget {
  const _Slider({
    required this.title,
    required this.maxRange,
    required this.minRange,
    required this.minValue,
    required this.maxValue,
    required this.onMinChanged,
    required this.onMaxChanged,
    required this.activeColor,
    required this.trackColor,
    required this.thumbColor,
  });

  final String title;
  final double maxRange;
  final double minRange;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onMinChanged;
  final ValueChanged<double> onMaxChanged;
  final Color activeColor;
  final Color trackColor;
  final Color thumbColor;

  @override
  State<_Slider> createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  late double minValue = widget.minValue;
  late double maxValue = widget.maxValue;

  void onMinChanged(double v) {
    setState(() => minValue = v);
    widget.onMinChanged(v);
  }

  void onMaxChanged(double v) {
    setState(() => maxValue = v);
    widget.onMaxChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = PullDownMenuItemTheme.of(context);
    final defaults = PullDownMenuItemTheme.defaults(context);
    final style = theme?.textStyle ?? defaults.textStyle!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: style,
            ),
          ),
          CupertinoRangeSlider(
            divisions: widget.maxRange.toInt(),
            max: widget.maxRange,
            min: widget.minRange,
            onMinChanged: onMinChanged,
            onMaxChanged: onMaxChanged,
            minValue: minValue,
            maxValue: maxValue,
            activeColor: widget.activeColor,
            thumbColor: widget.thumbColor,
            trackColor: widget.trackColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  minValue == widget.minRange
                      ? ''
                      : minValue.toInt().toString(),
                  style: style),
              Text(
                  maxValue == widget.maxRange
                      ? ''
                      : maxValue.toInt().toString(),
                  style: style)
            ],
          )
        ],
      ),
    );
  }
}