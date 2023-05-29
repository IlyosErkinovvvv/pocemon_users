import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_users/core/config/network_response_config.dart';
import 'package:pokemon_users/data/model/currency/currency_model.dart';
import 'package:pokemon_users/data/model/users/users_model.dart';
import 'package:pokemon_users/data/service/users_service.dart';

class UsersRepository {
  // instance
  UsersService usersService = UsersService();

  // isar DB
  late Isar db;

  // from Network
  Future<dynamic> getUsers() async {
    return await usersService.getUser().then((NetworkResponse response) async {
      if (response is NetworkSucced<List<UsersModel>>) {
        db = await openIsar();
        await putToDatabase(response.model);
        return await db.usersModels.where().findAll();
      } else {
        return response.toString();
      }
    });
  }

  // opens Database
  Future<Isar> openIsar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([UsersModelSchema, CurrencyModelSchema],
          directory: appDocDir.path);
    } else {
      return await Future.value(Isar.getInstance());
    }
  }

  // put Data
  Future<void> putToDatabase(List<UsersModel> data) async {
    await db.writeTxn(() async {
      await db.usersModels.clear();
      await db.usersModels.putAll(data);
    });
  }
}
