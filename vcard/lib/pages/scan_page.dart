import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/utils/contants.dart';

import 'form_page.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver = false;
  List lines = <String>[];
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      website = '',
      designation = '',
      phone = '',
      image = '';

  void createContact() {
    final contact = ContactModel(
      name: name,
      mobile: mobile,
      email: email,
      address: address,
      company: company,
      website: website,
      designation: designation,
      phone: phone,
      image: image,
    );
    context.goNamed(FormPage.routeName, extra: contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
        actions: [
          IconButton(
            onPressed: image.isEmpty ? null : createContact,
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Capturar'),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.photo_album),
                label: Text('Galeria'),
              ),
            ],
          ),
          if (isScanOver)
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    DragTargetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.company,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.designation,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.phone,
                      onDrop: getPropertyValue,
                    ),
                  ],
                ),
              ),
            ),
          if (isScanOver)
            Padding(padding: EdgeInsets.all(8), child: Text(hint)),
          Wrap(
            direction: Axis.horizontal,
            children: lines.map((line) => LineItem(line: line)).toList(),
          ),
        ],
      ),
    );
  }

  getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;
        break;
      case ContactProperties.mobile:
        mobile = value;
        break;
      case ContactProperties.email:
        email = value;
        break;
      case ContactProperties.address:
        address = value;
        break;
      case ContactProperties.company:
        company = value;
        break;
      case ContactProperties.website:
        website = value;
        break;
      case ContactProperties.designation:
        designation = value;
        break;
      case ContactProperties.phone:
        phone = value;
        break;
    }
  }

  void getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      setState(() {
        image = xFile.path;
      });
      EasyLoading.show(status: 'Aguarde...');
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final recognizedText = await textRecognizer.processImage(
        InputImage.fromFile(File(xFile.path)),
      );
      EasyLoading.dismiss();
      final tempList = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }
      setState(() {
        lines = tempList;
        isScanOver = true;
      });
    }
  }
}

class LineItem extends StatelessWidget {
  final String line;
  const LineItem({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: line,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        key: GlobalKey(),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.black45),
        child: Text(
          line,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      child: Chip(label: Text(line)),
    );
    //return Chip(label: Text(line));
  }
}

class DragTargetItem extends StatefulWidget {
  final String property;
  final Function(String, String) onDrop;

  const DragTargetItem({
    super.key,
    required this.property,
    required this.onDrop,
  });

  @override
  State<DragTargetItem> createState() => _DragTargetItemState();
}

class _DragTargetItemState extends State<DragTargetItem> {
  String dragItem = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(widget.property)),
        Expanded(
          flex: 2,
          child: DragTarget<String>(
            builder:
                (context, candidateData, rejectedData) => Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border:
                        candidateData.isNotEmpty
                            ? Border.all(color: Colors.red, width: 2)
                            : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          dragItem.isEmpty ? 'Arraste aqui' : dragItem,
                        ),
                      ),
                      if (dragItem.isNotEmpty)
                        InkWell(
                          onTap: () {
                            setState(() {
                              dragItem = '';
                            });
                          },
                          child: Icon(Icons.clear, size: 15),
                        ),
                    ],
                  ),
                ),
            // onAcceptWithDetails: (value) {
            //   setState(() {
            //     if (dragItem.isEmpty) {
            //       dragItem = value;
            //     } else {}
            //   });
            // },
            onAccept: (value) {
              setState(() {
                if (dragItem.isEmpty) {
                  dragItem = value;
                } else {
                  dragItem += ' $value';
                }
              });
              widget.onDrop(widget.property, dragItem);
            },
          ),
        ),
      ],
    );
  }
}
