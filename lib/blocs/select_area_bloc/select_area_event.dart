part of 'select_area_bloc.dart';

abstract class SelectAreaEvent extends Equatable {
  const SelectAreaEvent();

  @override
  List<Object> get props => [];
}

class SelectArea extends SelectAreaEvent {
  final MyArea selectedArea;
  const SelectArea({required this.selectedArea});
  @override
  List<Object> get props => [selectedArea];
}
