import 'package:earthquake_monitor/providers/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/helper_functions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void selectDate(AppDataProvider provider, String whichTime) async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.parse('1900-01-01'),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    date ??= DateTime.now();
    if (whichTime == 'starttime') {
      provider.starttime = DateFormat('yyyy-MM-dd').format(date);
    } else {
      provider.endtime = DateFormat('yyyy-MM-dd').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(title: Text('Configurações')),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: EdgeInsets.all(8),
            children: [
              Text(
                'Ajustes de Tempo',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Card(
                child: ListTile(
                  title: Text('Data Inicial'),
                  subtitle: Text(
                    getFormatedDateTime(
                      DateTime.parse(provider.starttime).millisecondsSinceEpoch,
                      'dd/MM/yyyy',
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      selectDate(provider, 'starttime');
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Data Final'),
                  subtitle: Text(
                    getFormatedDateTime(
                      DateTime.parse(provider.endtime).millisecondsSinceEpoch,
                      'dd/MM/yyyy',
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      selectDate(provider, 'endtime');
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Ajustes de Localização',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Card(
                child: SwitchListTile(
                  subtitle: Text(
                    (provider.currentCity == null)
                        ? 'Usar sua localização?'
                        : provider.cityInfo ?? '',
                  ),
                  title: Text(
                    provider.currentCity ?? 'Sua localização é desconhecida.',
                  ),
                  value: provider.shouldUseLocation,
                  onChanged: (bool value) async {
                    EasyLoading.show(status: 'Buscando localização...');
                    provider.getLocation(value);
                    EasyLoading.dismiss();
                  },
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Raio máximo: ${provider.maxRadiusKm.round()} Km'),
                      Slider(
                        min: 100,
                        max: provider.maxRadiusKmThreshold,
                        value: provider.maxRadiusKm,
                        onChanged: (double value) {
                          provider.maxRadiusKm = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Ajustes de Magnitude',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Magnitude mínima: ${provider.minmagnitude} na Escala Richter',
                      ),
                      Slider(
                        min: 0,
                        max: 10,
                        value: provider.minmagnitude.toDouble(),
                        onChanged: (double value) {
                          provider.minmagnitude = value.toInt();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: ElevatedButton(
                  onPressed: () {
                    provider.getEarthquakeData();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 20),
                      Text('Buscar'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
