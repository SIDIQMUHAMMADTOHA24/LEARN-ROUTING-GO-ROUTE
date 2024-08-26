import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tools_event.dart';
part 'tools_state.dart';

class ToolsBloc extends Bloc<ToolsEvent, int> {
  ToolsBloc() : super(0) {
    on<NextPageEvent>((event, emit) {
      emit(event.index);
    });

    on<ToolsInitialEvent>((event, emit) {
      final location = event.location;
      if (location.startsWith('/home')) {
        emit(0);
      } else if (location.startsWith('/search')) {
        emit(1);
      } else if (location.startsWith('/person')) {
        emit(2);
      }
    });
  }
}
