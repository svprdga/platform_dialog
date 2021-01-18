library platform_dialog;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Show a dialog using the platform specific UI guideliness (AlertDialog
/// for Android and CupertinoAlertDialog for iOS).
///
/// You can specify the title by sending a string or by sending a widget.
/// If you send a widget it will be used instead of the string.
///
/// You can specify the content by sending a string or by sending a widget.
/// If you send a widget it will be used instead of the string.
///
/// You can add up to three buttons: one for the positive action (ok, submit),
/// one for the neutral action (cancel), and one for the negative action (delete).
showPlatformDialog(BuildContext context,
    {String titleText,
      Widget titleWidget,
      String contentText,
      Widget contentWidget,
      String positiveText,
      String neutralText,
      String negativeText,
      VoidCallback onPositiveClick,
      VoidCallback onNeutralClick,
      VoidCallback onNegativeClick}) {
  var dialog = _PlatformDialog(
      titleText: titleText,
      titleWidget: titleWidget,
      contentText: contentText,
      contentWidget: contentWidget,
      positiveText: positiveText,
      neutralText: neutralText,
      negativeText: negativeText,
      onPositiveClick: onPositiveClick,
      onNeutralClick: onNeutralClick,
      onNegativeClick: onNegativeClick);

  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  } else if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}

class _PlatformDialog extends StatelessWidget {
  // ********************************* VARS ******************************** //

  final String titleText;
  final Widget titleWidget;
  final String contentText;
  final Widget contentWidget;
  final String positiveText;
  final String neutralText;
  final String negativeText;
  final VoidCallback onPositiveClick;
  final VoidCallback onNeutralClick;
  final VoidCallback onNegativeClick;

  // ***************************** CONSTRUCTORS **************************** //

  _PlatformDialog(
      {Key key,
        this.titleText,
        this.titleWidget,
        this.contentText,
        this.contentWidget,
        this.positiveText,
        this.neutralText,
        this.negativeText,
        this.onPositiveClick,
        this.onNeutralClick,
        this.onNegativeClick})
      : super(key: key);

  // ****************************** LIFECYCLE ****************************** //

  @override
  Widget build(BuildContext context) {
    // Create actions
    List<Widget> actions = List();

    if (negativeText != null && onNegativeClick != null && Platform.isAndroid) {
      actions.add(
          TextButton(child: Text(negativeText), onPressed: onNegativeClick));
    } else if (negativeText != null &&
        onNegativeClick != null &&
        Platform.isIOS) {
      actions.add(CupertinoDialogAction(
          child: Text(negativeText),
          isDestructiveAction: true,
          onPressed: onNegativeClick));
    }

    if (neutralText != null && onNeutralClick != null && Platform.isAndroid) {
      actions.add(
          TextButton(child: Text(neutralText), onPressed: onNeutralClick));
    } else if (neutralText != null &&
        onNeutralClick != null &&
        Platform.isIOS) {
      actions.add(CupertinoDialogAction(
          child: Text(neutralText), onPressed: onNeutralClick));
    }

    if (positiveText != null && onPositiveClick != null && Platform.isAndroid) {
      actions.add(TextButton(
        child: Text(positiveText),
        onPressed: onPositiveClick,
      ));
    } else if (positiveText != null &&
        onPositiveClick != null &&
        Platform.isIOS) {
      actions.add(CupertinoDialogAction(
        child: Text(positiveText),
        isDefaultAction: true,
        onPressed: onPositiveClick,
      ));
    }

    // Create dialog
    if (Platform.isAndroid) {
      return AlertDialog(
          title: titleWidget != null ? titleWidget : Text(titleText),
          content: contentWidget != null ? contentWidget : Text(contentText),
          actions: actions);
    } else if (Platform.isIOS) {
      return CupertinoAlertDialog(
          title: titleWidget != null ? titleWidget : Text(titleText),
          content: contentWidget != null ? contentWidget : Text(contentText),
          actions: actions);
    } else {
      return Container();
    }
  }
}

