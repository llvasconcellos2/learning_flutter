import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/pages/contact_details.dart';
import 'package:vcard/pages/scan_page.dart';
import 'package:vcard/providers/contact_provider.dart';
import 'package:vcard/utils/helper_functions.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    Provider.of<ContactProvider>(context, listen: false).getAllContacts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Contatos')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: Colors.blue.shade100,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            _fetchData();
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Todos'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder:
            (context, provider, child) => ListView.builder(
              itemCount: provider.contactList.length,
              itemBuilder: (context, index) {
                final contact = provider.contactList[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: FractionalOffset.centerRight,
                    color: Colors.red,
                    child: Icon(Icons.delete, size: 25, color: Colors.white),
                  ),
                  key: UniqueKey(),
                  confirmDismiss: _showConfimationDialog,
                  onDismissed: (direction) async {
                    await provider.deleteContact(contact.id);
                    showMsg(context, 'Registro removido com sucesso.');
                  },
                  child: ListTile(
                    onTap: () {
                      context.goNamed(
                        ContactDetails.routeName,
                        extra: contact.id,
                      );
                    },
                    title: Text(contact.name),
                    trailing: IconButton(
                      onPressed: () {
                        provider.updateFavorite(contact);
                      },
                      icon: Icon(
                        contact.favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }

  Future<bool?> _showConfimationDialog(DismissDirection direction) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Apagar Contato'),
            content: Text('Deseja apagar este contato?'),
            actions: [
              OutlinedButton(
                onPressed: () {
                  context.pop(false);
                },
                child: Text('Cancelar'),
              ),
              OutlinedButton(
                onPressed: () {
                  context.pop(true);
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _fetchData() {
    var provider = Provider.of<ContactProvider>(context, listen: false);
    switch (selectedIndex) {
      case 0:
        provider.getAllContacts();
        break;
      case 1:
        provider.getAllFavoriteContacts();
        break;
    }
  }
}
