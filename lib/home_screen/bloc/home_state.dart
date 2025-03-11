import 'package:graduation_project/home_screen/data/model/home_model_response/datum.dart';
import 'package:graduation_project/home_screen/data/model/items_model.dart';
import 'package:graduation_project/home_screen/data/model/services_model_response/service_model.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

// fetchCategories
class FetchCategoriesLoadingState extends HomeState {}

class FetchCategoriesSuccessState extends HomeState {
  final List<Datum> categories;

  FetchCategoriesSuccessState({required this.categories});
}

// fetchDiscountedItems
class FetchDiscountItemsLoadingState extends HomeState {}

class FetchDiscountItemsSuccessState extends HomeState {
  final List<ItemModel> items;

  FetchDiscountItemsSuccessState({required this.items});
}

// fetchHomeData
class FetchLoadingHomeDataState extends HomeState {}

class FetchSuccessHomeDataState extends HomeState {
  final List<Datum> categories;
  final List<ItemModel> items;

  FetchSuccessHomeDataState({required this.categories, required this.items});
}

class HomeErrorState extends HomeState {
  String message;
  HomeErrorState({required this.message});
}

// fetchServicesByCategory
class FetchServicesLoadingState extends HomeState {}

class FetchServicesSuccessState extends HomeState {
  final List<ServiceModel> services;
  FetchServicesSuccessState({required this.services});
}
class FetchServicesErrorState extends HomeState {
  final String message;
  FetchServicesErrorState({required this.message});
}
