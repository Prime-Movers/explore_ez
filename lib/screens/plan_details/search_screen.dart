import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/search_area_bloc/search_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAreaScreen extends StatefulWidget {
  const SearchAreaScreen({super.key});

  @override
  State<SearchAreaScreen> createState() => _SearchAreaScreenState();
}

class _SearchAreaScreenState extends State<SearchAreaScreen> {
  final _selectedAreas = <String>{};

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _buildAppBar(colorScheme),
      backgroundColor: colorScheme.onBackground,
      body: Column(
        children: [
          _buildSearchField(colorScheme),
          Expanded(
            child: BlocBuilder<SearchAreaBloc, SearchAreaState>(
              builder: (context, state) {
                if (state is SearchAreaLoaded) {
                  if (state.areas.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }
                  return ListView.builder(
                    itemCount: state.areas.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final MyArea area = state.areas[index];
                      return _listItem(context, area, colorScheme);
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(ColorScheme colorScheme) {
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

  Widget _buildSearchField(ColorScheme colorScheme) {
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

  Widget _listItem(BuildContext context, MyArea area, ColorScheme colorScheme) {
    final isSelected = _selectedAreas.contains(area.areaName);
    return ListTile(
      title: Text(
        area.areaName,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      tileColor: colorScheme.secondary.withOpacity(0.1),
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedAreas.remove(area.areaName);
          } else {
            _selectedAreas.add(area.areaName);
          }
        });
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? Icons.check_circle : Icons.circle_outlined,
          color: colorScheme.primary,
          size: 24,
        ),
      ),
    );
  }
}
