import 'package:bloc/bloc.dart';
import 'package:first_app/feature/home/data/model/populer_model.dart';
import 'package:first_app/core/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'populer_state.dart';

class PopulerCubit extends Cubit<PopulerState> {
  PopulerCubit() : super(PopulerInitial());

  static PopulerCubit get(context) => BlocProvider.of(context);

  PopularModel? popularModel = PopularModel();

  Future<void> getPopular() async {
    emit(PopulerLoading());
    popularModel = await ApiService.getData();
    if (popularModel != null) {
      emit(PopulerSuccess(popularModel!));
    } else {
      emit(
        PopulerError("Error fetching data"),
      );
    }
  }
}
