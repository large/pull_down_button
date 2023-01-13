import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../pull_down_button.dart';

/// This class has to "wrap" round to the class to be a statefull object
class PullDownMenuItemNumberPicker extends StatefulWidget
    implements PullDownMenuEntry {
  const PullDownMenuItemNumberPicker({
    super.key,
    required this.title,
    this.off = "",
    this.offWidth = 90,
    required this.value,
    required this.maxRange,
    required this.step,
    required this.onChanged,
    this.showButtons = true,
    this.subText = "",
    this.showAutoButton = false,
  });

  final String title;
  final String off;
  final int value;
  final int maxRange;
  final int step;
  final ValueChanged<int> onChanged;
  final bool showButtons;
  final String subText;
  final bool showAutoButton;
  final double offWidth;

  @override
  State<PullDownMenuItemNumberPicker> createState() =>
      _PullDownMenuItemNumberPickerState();
}

class _PullDownMenuItemNumberPickerState
    extends State<PullDownMenuItemNumberPicker> {
  late int value = widget.value;
  bool doNotShow = false;

  void onChanged(int v, {bool hideAuto = false}) {
    if(v == 0) doNotShow=false;
    if(hideAuto) doNotShow = true;
    print("hideauto $hideAuto - doNotShow $doNotShow - v=$v");
    setState(() => value = v);
    widget.onChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = PullDownMenuItemTheme.of(context);
    final defaults = PullDownMenuItemTheme.defaults(context);
    final style = theme?.textStyle ?? defaults.textStyle!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: style,
            ),
          ),
          NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              print("start");
            } else if (notification is ScrollUpdateNotification) {
              print("scrolling");
            } else if (notification is ScrollEndNotification) {
              print("end");
            } else if(notification is OverscrollNotification){
              print("doctor");
            }
            return true;
          },
            child: NumberPicker(
              value: value,
              step: widget.step,
              minValue: 0,
              maxValue: widget.maxRange,
              onChanged: onChanged,
              itemHeight: 60,
              itemWidth: 60,
              axis: Axis.horizontal,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme?.textStyle!.color! ?? defaults.textStyle!.color!,
                ),
              ),
              textStyle: style,
            ),
          ),
          if (widget.showAutoButton && value > 0 || doNotShow)
            Padding(
              padding: const EdgeInsets.all(4),
              child: CupertinoButton.filled(
                padding: const EdgeInsets.all(8),
                onPressed: () => onChanged(0, hideAuto: true),
                child: Text(widget.off, style: style),
              ),
            ),
          if (widget.showAutoButton && value == 0 && !doNotShow)
          SizedBox(
            width: widget.offWidth,
            child: Text(
              softWrap: true,
              widget.off,
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.showButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: CupertinoButton.filled(
                    padding: const EdgeInsets.all(8),
                    onPressed: () =>
                        onChanged(value - widget.step, hideAuto: true),
                    child: const Icon(CupertinoIcons.minus),
                  ),
                ),
                Visibility(
                  visible: value == 0,
                  child: SizedBox(
                    width: widget.offWidth,
                    child: Text(
                      softWrap: true,
                      widget.off,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Visibility(
                  child: SizedBox(width: widget.offWidth),
                  visible: value != 0,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: CupertinoButton.filled(
                    padding: const EdgeInsets.all(8),
                    onPressed: () =>
                        onChanged(value + widget.step, hideAuto: true),
                    child: const Icon(CupertinoIcons.add),
                  ),
                ),
              ],
            ),
          if (widget.subText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Text(
                widget.subText,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: style,
              ),
            ),
        ],
      ),
    );
  }
}
