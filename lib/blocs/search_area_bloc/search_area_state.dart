part of 'search_area_bloc.dart';

sealed class SearchAreaState extends Equatable {
  const SearchAreaState();

  @override
  List<Object> get props => [];
}

class SearchAreaInitial extends SearchAreaState {}

class SearchAreaLoading extends SearchAreaState {}

class SearchAreaLoaded extends SearchAreaState {
  final List<MyArea> areas;
  const SearchAreaLoaded({required this.areas});
}

class SearchAreaFailure extends SearchAreaState {}
