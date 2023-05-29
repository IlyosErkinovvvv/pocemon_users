import 'package:dio/dio.dart';
import 'package:pokemon_users/core/config/dio_catch_error_config.dart';
import 'package:pokemon_users/core/config/dio_config.dart';
import 'package:pokemon_users/core/config/network_response_config.dart';
import 'package:pokemon_users/core/constant/project_urls.dart';
import 'package:pokemon_users/data/model/pokemon/pokemon_model.dart';

class PokemonService {
  Future<NetworkResponse> getPokemon() async {
    try {
      Response response =
          await DioConfig.createRequest().get(ProjectUrls.pokemon);
      if (response.statusCode == 200) {
        return NetworkSucced((response.data as List)
            .map((e) => PokemonModel.fromJson(e))
            .toList());
      } else {
        return NetworkHttpError(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return NetworkException(DioCatchError.catchError(e));
    }
  }
}
