import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class InputWidgetsPage extends StatefulWidget {
  const InputWidgetsPage({super.key});

  @override
  State<InputWidgetsPage> createState() => _InputWidgetsPageState();
}

class _InputWidgetsPageState extends State<InputWidgetsPage> {
  final nameController = TextEditingController();
  bool checked = false;
  Gender gender = Gender.male;
  final countries = ['Australia', 'Brazil', 'Canada', 'Denmark', 'England'];
  String? country;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              //labelText: 'Name',
              label: Text('Name'),
            ),
            onChanged: (value) {
              if (kDebugMode) {
                print(value);
              }
            },
          ),
          Row(
            children: [
              Checkbox(
                value: checked,
                onChanged: (value) {
                  setState(() {
                    checked = value!;
                  });
                },
              ),
              Text('Flutter'),
            ],
          ),
          Row(
            children: [
              Radio<Gender>(
                value: Gender.male,
                groupValue: gender,
                onChanged: (Gender? value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              Text('Male'),
              Radio<Gender>(
                value: Gender.female,
                groupValue: gender,
                onChanged: (Gender? value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              Text('Female'),
            ],
          ),
          DropdownButton<String>(
            hint: Text('Select your country'),
            value: country,
            items:
                countries
                    .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                country = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (kDebugMode) {
                print(nameController.text);
              }
            },
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
