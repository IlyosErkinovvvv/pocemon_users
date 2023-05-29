import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_users/core/config/network_response_config.dart';
import 'package:pokemon_users/data/model/currency/currency_model.dart';
import 'package:pokemon_users/data/model/users/users_model.dart';
import 'package:pokemon_users/data/service/currency_service.dart';

class CurrencyRepository {
  // instance
  CurrencyService currencyService = CurrencyService();

  // isar DB
  late Isar currencyDB;

  // getCurrency
  Future<dynamic> getCurrency() async {
    return await currencyService
        .getCurrency()
        .then((NetworkResponse response) async {
      if (response is NetworkSucced<List<CurrencyModel>>) {
        // initialization
        currencyDB = await openIsar();
        await putToDatabase(response.model);
        return await currencyDB.currencyModels.where().findAll();
      } else {
        return response;
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
  Future<void> putToDatabase(List<CurrencyModel> data) async {
    await currencyDB.writeTxn(() async {
      await currencyDB.currencyModels.clear();
      await currencyDB.currencyModels.putAll(data);
    });
  }
}
