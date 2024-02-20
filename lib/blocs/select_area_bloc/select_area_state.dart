part of 'select_area_bloc.dart';

class SelectAreaState extends Equatable {
  final String selectArea;
  const SelectAreaState(this.selectArea);

  @override
  List<Object> get props => [selectArea];
}
