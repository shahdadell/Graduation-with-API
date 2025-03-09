import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/home_event.dart';
import 'package:graduation_project/home_screen/bloc/home_state.dart';
import 'package:graduation_project/home_screen/data/repo/home_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<FetchHomeDataEvent>(fetchHomeData);
    on<FetchCategoriesEvent>(fetchCategories);
    on<FetchDiscountEvent>(fetchDiscountedItems);
  }

  Future<void> fetchHomeData(FetchHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(FetchLoadingHomeDataState());
    try {
      final categories = await HomeRepo.fetchCategories();
      final items = await HomeRepo.fetchDiscountedItems();
      emit(FetchSuccessHomeDataState(categories: categories, items: items));
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  Future<void> fetchCategories(FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(FetchCategoriesLoadingState());
    try {
      final categories = await HomeRepo.fetchCategories();
      emit(FetchCategoriesSuccessState(categories: categories));
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  Future<void> fetchDiscountedItems(FetchDiscountEvent event, Emitter<HomeState> emit) async {
    emit(FetchDiscountItemsLoadingState());
    try {
      final items = await HomeRepo.fetchDiscountedItems();
      emit(FetchDiscountItemsSuccessState(items: items));
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }
}
