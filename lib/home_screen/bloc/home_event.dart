import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';

class HomeEvent {}

class FetchCategoriesEvent extends HomeEvent {
  final HomeModelResponse params;
  FetchCategoriesEvent(this.params);
}

class FetchDiscountEvent extends HomeEvent {
  final HomeModelResponse params;
  FetchDiscountEvent(this.params);
}
class FetchHomeDataEvent extends HomeEvent {
  final HomeModelResponse? params;
  FetchHomeDataEvent(this.params);
}
