import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  Database? db;

  Future open () async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'plant.db');
    
    log(path);

    db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            Create Table plants(
              id integer primary key autoIncrement,
              plant vaarchar(255) not null,
              image varchar(255) not null,
              price double not null
            );
          ''' );
      }
      );
  }
}