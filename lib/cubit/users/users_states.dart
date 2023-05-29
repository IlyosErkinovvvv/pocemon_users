import 'package:bloc/bloc.dart';
import 'package:isar/isar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pokemon_users/data/model/users/users_model.dart';
import 'package:pokemon_users/data/repository/users_repository.dart';
part 'users_cubit.dart';

abstract class UsersStates {
  UsersStates();
}

class UsersInitState extends UsersStates {
  UsersInitState();
}
class UsersLoadingState extends UsersStates {
  UsersLoadingState();
}

class UsersErrorState extends UsersStates {
  String error;
  UsersErrorState(this.error);
}

class UsersOnlineState extends UsersStates {
  List<UsersModel> data;
  UsersOnlineState(this.data);
}

class UsersOfflineState extends UsersStates {
  List<UsersModel> list;
  UsersOfflineState(this.list);
}