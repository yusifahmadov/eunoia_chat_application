import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  final _themeController = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get isLightMode => _themeController.stream;
  bool get themeValue => _themeController.value;
}
