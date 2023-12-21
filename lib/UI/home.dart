import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:explore_ez/util/places.dart';
import 'package:explore_ez/widgets/horizontal_place_item.dart';
import 'package:explore_ez/widgets/icon_badge.dart';
import 'package:explore_ez/widgets/search_bar.dart';
import 'package:explore_ez/widgets/vertical_place_item.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Plan your trip",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: searchbar(),
          ),
          buildHorizontalList(context),
          buildVerticalList(),
        ],
      ),
    ), onWillPop: () async =>false)
    ;
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 :  places.length, 
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place);
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
