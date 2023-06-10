import 'package:bloc/bloc.dart';
import 'package:pokemon_users/data/model/currency/currency_model.dart';
import 'package:pokemon_users/data/repository/currency_repository.dart';
// import 'package:pokemon_users/data/service/currency_service.dart';
part 'currency_cubit.dart';

abstract class CurrencyState {
  CurrencyState();
}

class CurrencyInitstate extends CurrencyState {
  CurrencyInitstate();
}

class CurrencyLoadingState extends CurrencyState {
  CurrencyLoadingState();
}

class CurrencyErrorState extends CurrencyState {
  final String error;
  CurrencyErrorState(this.error);
}

class CurrencySuccesedState extends CurrencyState {
  final List<CurrencyModel> data;
  CurrencySuccesedState(this.data);
}
