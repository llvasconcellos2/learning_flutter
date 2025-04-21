import 'package:flutter/material.dart';

void showConfirmDialog(
  BuildContext context, {
  String message = 'Deseja continuar?',
  String title = 'confirme',
  VoidCallback? onContinue,
}) {
  // set up the buttons
  Widget cancelButton = OutlinedButton(
    child: Row(
      children: [Icon(Icons.cancel), SizedBox(width: 10), Text("Cancelar")],
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = ElevatedButton(
    onPressed: onContinue,
    child: Row(
      children: [Icon(Icons.check), SizedBox(width: 10), Text("Continuar")],
    ),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    alignment: Alignment.center,
    actionsOverflowAlignment: OverflowBarAlignment.center,
    title: Text(title),
    content: Text(message),
    actions: [cancelButton, SizedBox(height: 10), continueButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
