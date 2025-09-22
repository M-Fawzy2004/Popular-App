import 'package:bloc/bloc.dart';
import 'package:first_app/feature/details_popular/data/model/popular_people_details_model.dart';
import 'package:first_app/core/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'details_popular_state.dart';

class DetailsPopularCubit extends Cubit<DetailsPopularState> {
  DetailsPopularCubit() : super(DetailsPopularInitial());

  static DetailsPopularCubit get(context) => BlocProvider.of(context);
  PopularPeopleDetailsModel? popularPeopleDetailsModel =
      PopularPeopleDetailsModel();

  getDetails(num id) async {
    emit(DetailsPopularLoading());
    var response = await ApiService.getPersonDetails(id);
    if (response != null) {
      popularPeopleDetailsModel = response;
      emit(DetailsPopularSuccess());
    } else {
      emit(DetailsPopularError());
    }
  }
}
