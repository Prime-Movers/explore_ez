import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/select_area_bloc/select_area_bloc.dart';

import 'package:explore_ez/blocs/search_area_bloc/search_area_bloc.dart';

import 'plan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_ez/components/visible_button.dart';

class SearchAreaScreen extends StatelessWidget {
  const SearchAreaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _buildAppBar(colorScheme, context),
      backgroundColor: colorScheme.onBackground,
      body: Column(
        children: [
          _buildSearchField(colorScheme, context),
          Expanded(
            child: BlocBuilder<SearchAreaBloc, SearchAreaState>(
              builder: (context, state) {
                if (state is SearchAreaLoaded) {
                  if (state.areas.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }
                  List<String> areas = state.areas;
                  return BlocBuilder<SelectAreaBloc, SelectAreaState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: areas.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final isSelected = state.selectArea == areas[index];
                          return _listItem(
                              context, areas[index], colorScheme, isSelected);
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<SelectAreaBloc, SelectAreaState>(
        builder: (context, state) {
          if (state.selectArea != '') {
            return VisibleButton(
              colorScheme: colorScheme,
              visible: true,
              alignment: Alignment.bottomRight,
              isPop: false,
              isPush: true,
              widget: const PlanDetails(),
              text: 'Next',
              onPressed: () {
                context
                    .read<PlanDetailsBloc>()
                    .add(GetArea(area: state.selectArea));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const PlanDetails();
                  }),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(ColorScheme colorScheme, BuildContext context) {
    return AppBar(
      backgroundColor: colorScheme.onBackground,
      elevation: 0, // Remove default shadow
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.background),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Explore EZ',
        style: TextStyle(
          color: colorScheme.background,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchField(ColorScheme colorScheme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: colorScheme.onPrimary,
          hintText: 'Search...',
          hintStyle: TextStyle(color: colorScheme.background),
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorScheme.background, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colorScheme.secondary),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: colorScheme.onPrimary,
            size: 24,
          ),
        ),
        onChanged: (value) =>
            context.read<SearchAreaBloc>().add(SearchArea(value: value)),
      ),
    );
  }

  Widget _listItem(BuildContext context, String area, ColorScheme colorScheme,
      bool isSelected) {
    return ListTile(
      title: Text(
        /*area.areaName*/ area,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      tileColor: colorScheme.secondary.withOpacity(0.1),
      onTap: () {
        context.read<SelectAreaBloc>().add(SelectArea(selectedArea: area));
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: colorScheme.primary, size: 24),
      ),
    );
  }
}
