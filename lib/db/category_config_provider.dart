import 'package:gankclient/db/sql_provider.dart';
import 'package:gankclient/model/category_tab_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryConfigProvider extends BaseDbProvider {
  final name = "categoryConfig";
  final columnId = "_id";
  final columnImageUrl = "coverImageUrl";
  final columnDesc = "desc";
  final columnTitle = "title";
  final columnType = "type";
  final columnIndex = "categoryIndex";

  CategoryConfigProvider();

  @override
  tableName() {
    return name;
  }

  String id;
  String coverImageUrl;
  String desc;
  String title;
  String type;
  int index;

  @override
  tableSqlString() {
    return '''
     create table $name (
        $columnId text primary key,
        $columnImageUrl text not null,
        $columnDesc text not null,
        $columnTitle text not null,
        $columnType text not null,
        $columnIndex int not null
        );
      ''';
  }

  CategoryConfigProvider.fromMap(Map map) {
    id = map[columnId];
    coverImageUrl = map[columnImageUrl];
    desc = map[columnDesc];
    title = map[columnTitle];
    type = map[columnType];
    index = map[columnIndex];
  }

  Future _getCategoryConfigProvider(Database db) async {
    var list = await db.query(
      name,
      columns: [
        columnId,
        columnImageUrl,
        columnDesc,
        columnTitle,
        columnType,
        columnIndex
      ],
      where: "$columnIndex !=-1",
    );
    if (list.length > 0) {
      return list;
    }
    return null;
  }

  Future _getCategoryConfigInsertProvider(Database db, String id) async {
    var list = await db.query(name,
        columns: [
          columnId,
          columnImageUrl,
          columnDesc,
          columnTitle,
          columnType,
          columnIndex
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (list.length > 0) {
      return CategoryConfigProvider.fromMap(list.first);
    }
    return null;
  }

  Future<int> insert(CategoryTabModel model) async {
    var database = await getDataBase();
    var provider = await _getCategoryConfigInsertProvider(database, model.id);
    if (provider != null) {
      await database.delete(name, where: "$columnId=?", whereArgs: [model.id]);
    }
    return await database.insert(name, model.toJson());
  }

  Future<List<CategoryTabModel>> getData() async {
    Database db = await getDataBase();
    var provider = await _getCategoryConfigProvider(db);
    if (provider != null) {
      List<CategoryTabModel> list = List();
      for (var providerMap in provider) {
        var model = CategoryTabModel.fromJson(providerMap);
        list.add(model);
      }
      return list;
    }
    return null;
  }
}
