import 'dart:io';

import 'package:earthquake_monitor/pages/settings_page.dart';
import 'package:earthquake_monitor/providers/app_data_provider.dart';
import 'package:earthquake_monitor/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/earthquake_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppDataProvider provider;

  @override
  void initState() {
    provider = Provider.of<AppDataProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider.init();
    super.didChangeDependencies();
  }

  void _showSortingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort by'),
          content: Consumer<AppDataProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var e in OrderBy.values)
                    RadioGroup(
                      groupValue: provider.orderBy.value,
                      value: e.value,
                      label: e.label,
                      onChanged: (value) {
                        provider.setOrderByValue(value!);
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  _openMap(Geometry geo) async {
    String url = '${geo.coordinates?[1]},${geo.coordinates?[0]}';

    if (Platform.isAndroid) {
      url = 'geo:0,0?q=$url';
    } else if (Platform.isIOS) {
      url = 'https://maps.apple.com/?q=$url';
    } else {
      url = 'https://maps.google.com/?q=$url';
    }

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Não é possível executar esta tarefa.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/center-location.png'),
        ),
        centerTitle: true,
        title: Text('Epicentro'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
          IconButton(onPressed: _showSortingDialog, icon: Icon(Icons.sort)),
        ],
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) {
          if (!provider.hasDataLoaded) {
            return Center(child: Text('Loading...'));
          }
          if (provider.hasDataLoaded &&
              provider.earthquakeModel!.features!.isEmpty) {
            return Center(child: Text('No records found.'));
          }
          return ListView.builder(
            itemCount: provider.earthquakeModel!.features!.length,
            itemBuilder: (context, index) {
              final data =
                  provider.earthquakeModel!.features![index].properties;
              return GestureDetector(
                onTap: () {
                  _openMap(
                    provider.earthquakeModel!.features![index].geometry!,
                  );
                },
                child: ListTile(
                  title: Text(
                    translate(data!.place ?? data.title ?? 'Unknown'),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(getFormatedDateTime(data.time!, 'dd/MM/yyyy')),
                      Text(getFormatedDateTime(data.time!, 'HH:mm')),
                    ],
                  ),
                  leading: Chip(
                    backgroundColor:
                    // (data.alert != null) ??
                    provider.getAlertColor(data.alert ?? ''),
                    label: Text(
                      data.mag.toString(),
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 3,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RadioGroup extends StatelessWidget {
  final String groupValue;
  final String value;
  final String label;
  final Function(String?) onChanged;

  const RadioGroup({
    super.key,
    required this.groupValue,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }
}
