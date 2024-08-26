part of 'tools_bloc.dart';

abstract class ToolsEvent extends Equatable {
  const ToolsEvent();

  @override
  List<Object> get props => [];
}

class NextPageEvent extends ToolsEvent {
  const NextPageEvent(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class ToolsInitialEvent extends ToolsEvent {
  final String location;

  const ToolsInitialEvent({required this.location});

  @override
  List<Object> get props => [location];
}
