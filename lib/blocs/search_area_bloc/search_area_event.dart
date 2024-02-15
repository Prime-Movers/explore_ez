part of 'search_area_bloc.dart';

sealed class SearchAreaEvent extends Equatable {
  const SearchAreaEvent();

  @override
  List<Object> get props => [];
}

class SearchArea extends SearchAreaEvent {
  final String value;
  const SearchArea({required this.value});
}
