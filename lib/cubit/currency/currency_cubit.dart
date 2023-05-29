part of 'currency_states.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyInitstate()) {
    getCurrency();
  }

  // instance
  CurrencyRepository currencyRepository = CurrencyRepository();

  // get from repository
  Future<void> getCurrency() async {
    emit(CurrencyLoadingState());
    await currencyRepository.getCurrency().then((data) {
      if (data is List<CurrencyModel>) {
        emit(CurrencySuccesedState(data));
      } else {
        emit(CurrencyErrorState(data));
      }
    });
  }
}
