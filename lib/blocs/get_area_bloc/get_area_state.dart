part of 'get_area_bloc.dart';

sealed class GetAreaState extends Equatable {
  const GetAreaState();

  @override
  List<Object> get props => [];
}

class GetAreaInitial extends GetAreaState {}

class GetAreaSuccess extends GetAreaState {
  final List<MyArea> areas;
  const GetAreaSuccess(this.areas);
}

class GetAreaFailure extends GetAreaState {}

class GetAreaLoading extends GetAreaState {}
