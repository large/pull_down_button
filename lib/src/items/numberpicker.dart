
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../pull_down_button.dart';

/// This class has to "wrap" round to the class to be a statefull object
class PullDownMenuItemNumberPicker extends StatefulWidget implements PullDownMenuEntry {

  const PullDownMenuItemNumberPicker(
      {super.key,
        required this.title,
      required this.off,
      required this.value,
      required this.maxRange,
      required this.step,
      required this.onChanged,
      this.showButtons = true,
        this.subText = "",
      });

  final String title;
  final String off;
  final int value;
  final int maxRange;
  final int step;
  final ValueChanged<int> onChanged;
  final bool showButtons;
  final String subText;

  @override
  State<PullDownMenuItemNumberPicker> createState() => _PullDownMenuItemNumberPickerState();
}

class _PullDownMenuItemNumberPickerState extends State<PullDownMenuItemNumberPicker> {
  late int value = widget.value;

  void onChanged(int v) {
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
          NumberPicker(
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
          if(widget.showButtons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.all(8),
                  onPressed: () => setState(() {
                    final newValue = value - widget.step;
                    value = newValue.clamp(0, widget.maxRange);
                  }),
                  child: const Icon(CupertinoIcons.minus),
                ),
              ),
              Visibility(
                visible: value == 0,
                child: Text(
                  widget.off,
                  style: style,
                ),
              ),
              SizedBox(
                width: 45,
                height: 45,
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.all(8),
                  onPressed: () => setState(() {
                    final newValue = value + widget.step;
                    value = newValue.clamp(0, widget.maxRange);
                  }),
                  child: const Icon(CupertinoIcons.add),
                ),
              ),
            ],
          ),
          if(widget.subText.isNotEmpty)
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
