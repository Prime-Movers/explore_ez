part of 'get_area_bloc.dart';

sealed class GetAreaEvent extends Equatable {
  const GetAreaEvent();

  @override
  List<Object> get props => [];
}

class GetArea extends GetAreaEvent {}
