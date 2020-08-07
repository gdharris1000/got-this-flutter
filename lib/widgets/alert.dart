import 'package:flutter/material.dart';

class AlertMessage {
  AlertMessage({this.buildContext, this.messageContent, this.messageTitle});
  final BuildContext buildContext;
  final String messageTitle;
  final String messageContent;

  displayMessage() {
    showDialog(
        context: buildContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(messageTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(messageContent)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              )
            ],
          );
        });
  }
}
