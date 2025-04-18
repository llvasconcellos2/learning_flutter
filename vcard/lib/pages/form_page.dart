import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/providers/contact_provider.dart';
import 'package:vcard/utils/helper_functions.dart';

import '../utils/contants.dart';
import 'home_page.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final ContactModel contactModel;

  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final websiteController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contactModel.name;
    mobileController.text = widget.contactModel.mobile;
    emailController.text = widget.contactModel.email;
    addressController.text = widget.contactModel.address;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    websiteController.text = widget.contactModel.website;
    phoneController.text = widget.contactModel.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
        actions: [IconButton(onPressed: saveContact, icon: Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrorMessage;
                }
                return null;
              },
            ),
            TextFormField(
              controller: designationController,
              decoration: InputDecoration(labelText: 'Cargo'),
            ),
            TextFormField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Celular'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrorMessage;
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              controller: companyController,
              decoration: InputDecoration(labelText: 'Empresa'),
            ),
            TextFormField(
              controller: websiteController,
              decoration: InputDecoration(labelText: 'Website'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    companyController.dispose();
    designationController.dispose();
    websiteController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void saveContact() async {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.mobile = mobileController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.website = websiteController.text;
      widget.contactModel.phone = phoneController.text;
    }
    Provider.of<ContactProvider>(context, listen: false)
        .insertContact(widget.contactModel)
        .then((value) {
          if (value > 0) {
            showMsg(context, 'Registro salvo.');
            context.goNamed(HomePage.routeName);
          }
        })
        .catchError((error) {
          showMsg(context, 'Falha ao salvar registro.');
          if (kDebugMode) {
            print(error);
          }
        });
  }
}
