import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vcard/providers/contact_provider.dart';

import '../models/contact_model.dart';
import '../utils/helper_functions.dart';

class ContactDetails extends StatefulWidget {
  static String routeName = 'details';
  final int id;

  const ContactDetails({super.key, required this.id});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  late int id;

  @override
  void initState() {
    id = widget.id;
    print(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes')),
      body: Consumer<ContactProvider>(
        builder:
            (context, provider, child) => FutureBuilder<ContactModel>(
              future: provider.getContactById(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final contact = snapshot.data!;
                  return ListView(
                    padding: EdgeInsets.all(8),
                    children: [
                      Image.file(
                        File(contact.image),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        title: Text(contact.mobile),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                callContact(contact.mobile);
                              },
                              icon: Icon(Icons.call),
                            ),
                            IconButton(
                              onPressed: () {
                                smsContact(contact.mobile);
                              },
                              icon: Icon(Icons.sms),
                            ),
                          ],
                        ),
                      ),

                      if (contact.phone.isNotEmpty)
                        ListTile(
                          title: Text(contact.phone),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  callContact(contact.phone);
                                },
                                icon: Icon(Icons.call),
                              ),
                              IconButton(
                                onPressed: () {
                                  smsContact(contact.phone);
                                },
                                icon: Icon(Icons.sms),
                              ),
                            ],
                          ),
                        ),
                      if (contact.email.isNotEmpty)
                        ListTile(
                          title: Text(contact.email),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  emailContact(contact.email);
                                },
                                icon: Icon(Icons.email),
                              ),
                            ],
                          ),
                        ),
                      if (contact.address.isNotEmpty)
                        ListTile(
                          title: Text(contact.address),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  addressMapContact(contact.address);
                                },
                                icon: Icon(Icons.location_on),
                              ),
                            ],
                          ),
                        ),
                      if (contact.website.isNotEmpty)
                        ListTile(
                          title: Text(contact.website),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  goToContactWebsite(contact.website);
                                },
                                icon: Icon(Icons.link),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Falha ao carregar os dados.'),
                  );
                }
                return const Center(child: Text('Aguarde...'));
              },
            ),
      ),
    );
  }

  void callContact(String mobile) async {
    final url = 'tel:$mobile';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Não é possível executar esta tarefa.');
    }
  }

  void smsContact(String mobile) async {
    final url = 'sms:$mobile';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Não é possível executar esta tarefa.');
    }
  }

  void emailContact(String email) async {
    final url = 'mailto:$email?subject=A Message to you!';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Não é possível executar esta tarefa.');
    }
  }

  void addressMapContact(String address) async {
    String url = '';

    if (Platform.isAndroid) {
      url = 'geo:0,0?q=$address';
    } else if (Platform.isIOS) {
      url = 'https://maps.apple.com/?q=$address';
    } else {
      url = 'https://maps.google.com/?q=$address';
    }

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Não é possível executar esta tarefa.');
    }
  }

  void goToContactWebsite(String website) async {
    final url = 'https://$website';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Não é possível executar esta tarefa.');
    }
  }
}
