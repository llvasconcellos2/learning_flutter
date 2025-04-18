import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:vcard/models/contact_model.dart';

class DbHelper {
  final String _createTableContacts = '''
  CREATE TABLE $tableContact(
    $tblContactColId INTEGER PRIMARY KEY AUTOINCREMENT,
    $tblContactColName TEXT,
    $tblContactColMobile TEXT,
    $tblContactColEmail TEXT,
    $tblContactColAddress TEXT,
    $tblContactColCompany TEXT,
    $tblContactColDesignation TEXT,
    $tblContactColWebsite TEXT,
    $tblContactColPhone TEXT,
    $tblContactColImage TEXT,
    $tblContactColFavorite INTEGER
  );
  ''';
  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = path.join(root, 'contact.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(_createTableContacts);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          // SQL Lite cant alter table and columns
          await db.execute('alter table $tableContact rename to contacts_old');
          await db.execute(_createTableContacts);
          final rows = await db.query('contact_old');
          for (var row in rows) {
            await db.insert(tableContact, row);
          }
          await db.execute('drop table if exists contact_old');
        }
      },
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db.query(tableContact, where: 'id = $id');
    return ContactModel.fromMap(mapList.first);
  }

  Future<List<ContactModel>> getAllFavoriteContacts() async {
    final db = await _open();
    final mapList = await db.query(
      tableContact,
      where: '$tblContactColFavorite = 1',
    );
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  Future<int> deleteContact(int id) async {
    final db = await _open();
    //return db.delete(tableContact, where: '$tblContactColId = ?', whereArgs: [id]);
    return db.delete(tableContact, where: '$tblContactColId = $id');
  }

  Future<int> updateContactField(int id, Map<String, dynamic> map) async {
    final db = await _open();
    return db.update(tableContact, map, where: '$tblContactColId = $id');
  }

  Future<int> updateFavorite(int id, int value) async {
    final db = await _open();
    return db.update(tableContact, {
      tblContactColFavorite: value,
    }, where: '$tblContactColId = $id');
  }
}
