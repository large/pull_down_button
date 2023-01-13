// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

import 'item_examples.dart';
import 'setup.dart';

/// This file includes basic example for [PullDownButton] that uses all of
/// available menu items and [PullDownMenuPosition.automatic].
///
/// For more specific examples (per menu item, theming, positioning) check
/// [ItemExamples] on [GitHub](https://github.com/notDmDrl/pull_down_button/tree/main/example/lib)
void main() {
  runApp(const MyApp());
}

@immutable
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final edgeInsets = MediaQuery.of(context).padding;
    final padding = EdgeInsets.only(
      left: 16 + edgeInsets.left,
      top: 24 + edgeInsets.top,
      right: 16 + edgeInsets.right,
      bottom: 24 + edgeInsets.bottom,
    );

    return ListView.separated(
      padding: padding,
      reverse: true,
      itemBuilder: (context, index) {
        final isSender = index.isEven;

        return Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: ExampleMenu(
            position: PullDownMenuPosition.automatic,
            applyOpacity: false,
            builder: (_, showMenu) => CupertinoButton(
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              child: _MessageExample(isSender: isSender),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: 20,
    );
  }
}

@immutable
class ExampleMenu extends StatelessWidget {
  const ExampleMenu({
    super.key,
    required this.position,
    required this.builder,
    this.applyOpacity = true,
  });

  final PullDownMenuPosition position;
  final PullDownMenuButtonBuilder builder;
  final bool applyOpacity;

  @override
  Widget build(BuildContext context) => PullDownButton(
        itemBuilder: (context) => [
          /*PullDownMenuItemSlider(
            title: "Chart upper and lower bounds",
            minValue: -300,
            maxValue: 800,
            minRange: -300,
            maxRange: 800,
            onMinChanged: (v) {},
            onMaxChanged: (v) {},
          ),*/
          const PullDownMenuDivider(),
          PullDownMenuActionsRow.small(
            items: [
              PullDownMenuItem(
                onTap: () {},
                title: 'Cut',
                icon: CupertinoIcons.scissors,
              ),
              PullDownMenuItem(
                onTap: () {},
                title: 'Copy',
                icon: CupertinoIcons.doc_on_doc,
              ),
              PullDownMenuItem(
                onTap: () {},
                title: 'Paste',
                icon: CupertinoIcons.doc_on_clipboard,
              ),
              PullDownMenuItem(
                onTap: () {},
                title: 'Look Up',
                icon: CupertinoIcons.doc_text_search,
              ),
            ],
          ),
          const PullDownMenuDivider.large(),
          PullDownMenuItemNumberPicker(
            title: 'Some number',
            value: 0,
            step: 1,
            maxRange: 100,
            onChanged: (int value) {
              debugPrint("numberpicker $value");
            },
            showButtons: true,
            //subText: "This is the subtext",
          ),
          PullDownMenuItemNumberPicker(
            title: 'Set static Y-axis',
            off: "Auto",
            value: 0,
            step: 5,
            maxRange: 1000,
            onChanged: (int value) {
              debugPrint("numberpicker $value");
            },
            showButtons: false,
            //subText: "This is the subtext",
          ),
          PullDownMenuItemNumberPicker(
            title: 'Autobutton test',
            off: "Automagic",
            value: 0,
            step: 15,
            maxRange: 500,
            onChanged: (int value) {
              debugPrint("numberpicker $value");
            },
            showButtons: false,
            showAutoButton: true,
            subText: "This is the subtext",
          ),
          const PullDownMenuDivider.large(),
          PullDownMenuItem(
            enabled: false,
            title: 'Select',
            onTap: () {},
            icon: CupertinoIcons.checkmark_circle,
          ),
          const PullDownMenuDivider(),
          PullDownMenuItem(
            title: 'Connect to remote server',
            onTap: () {},
            icon: CupertinoIcons.cloud_upload,
          ),
          const PullDownMenuDivider.large(),
          PullDownMenuItem.selectable(
            title: 'Grid',
            selected: true,
            onTap: () {},
            icon: CupertinoIcons.square_grid_2x2,
          ),
          const PullDownMenuDivider(),
          PullDownMenuItem.selectable(
            title: 'List',
            selected: false,
            onTap: () {},
            icon: CupertinoIcons.list_bullet,
          ),
          const PullDownMenuDivider.large(),
          /*PullDownMenuItemSlider(
            title: "Chart range",
            minValue: -10,
            maxValue: 200,
            minRange: -300,
            maxRange: 900,
            onMinChanged: (value) {
              debugPrint("value $value");
            },
            onMaxChanged: (value) {
              debugPrint("value $value");
            },
            activeColor: Colors.redAccent,
          ),*/
          const PullDownMenuDivider.large(),
          PullDownMenuActionsRow.medium(
            items: [
              PullDownMenuItem(
                enabled: false,
                onTap: () {},
                title: 'Inbox',
                icon: CupertinoIcons.tray_arrow_down,
              ),
              PullDownMenuItem(
                onTap: () {},
                title: 'Archive',
                icon: CupertinoIcons.archivebox,
              ),
              PullDownMenuItem(
                onTap: () {},
                title: 'Trash',
                isDestructive: true,
                icon: CupertinoIcons.delete,
              ),
            ],
          ),
        ],
        applyOpacity: applyOpacity,
        position: position,
        buttonBuilder: builder,
      );
}

// Eyeballed message box from iMessage
@immutable
class _MessageExample extends StatelessWidget {
  const _MessageExample({
    required this.isSender,
  });

  final bool isSender;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 267,
        child: Material(
          color: isSender
              ? CupertinoColors.systemBlue.resolveFrom(context)
              : CupertinoColors.systemFill.resolveFrom(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              isSender
                  ? 'How’s next Tuesday? Can’t wait to see you! 🤗'
                  : 'Let’s get lunch! When works for you? 😋',
              style: TextStyle(
                fontSize: 17,
                height: 22 / 17,
                letterSpacing: -0.41,
                fontFamily: '.SF Pro Text',
                color: isSender
                    ? CupertinoColors.label.darkColor
                    : CupertinoColors.label.resolveFrom(context),
              ),
            ),
          ),
        ),
      );
}
