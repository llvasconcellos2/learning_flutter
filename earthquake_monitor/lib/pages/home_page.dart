import 'package:earthquake_monitor/providers/app_data_provider.dart';
import 'package:earthquake_monitor/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/center-location.png'),
        ),
        centerTitle: true,
        title: Text('Epicentro'),
        actions: [
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
              return ListTile(
                title: Text(data!.place ?? data.title ?? 'Unknown'),
                trailing: Column(
                  children: [
                    Text(getFormatedDateTime(data.time!, 'dd/MM/yyyy')),
                    Text(getFormatedDateTime(data.time!, 'HH:mm')),
                  ],
                ),
                leading: Chip(
                  backgroundColor:
                  // (data.alert != null) ??
                  provider.getAlertColor(data.alert ?? ''),
                  label: Text(data.mag.toString()),
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
