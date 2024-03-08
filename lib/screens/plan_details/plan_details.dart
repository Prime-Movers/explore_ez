import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/fetch_places_bloc/fetch_places_bloc.dart';
import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/select_hotel_bloc/select_hotel_bloc.dart';
import 'package:explore_ez/screens/plan_details/place_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_ez/components/textfield.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:explore_ez/components/visible_button.dart';
import "dart:async";
// import "package:location/location.dart";

class PlanDetails extends StatefulWidget {
  const PlanDetails({super.key});

  @override
  State<PlanDetails> createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController startdateInputController = TextEditingController();
  TextEditingController enddateInputController = TextEditingController();
  TextEditingController startTimeInputController = TextEditingController();
  TextEditingController endTimeInputController = TextEditingController();
  TextEditingController budgetInputController = TextEditingController();
  TextEditingController hotelInputController = TextEditingController();

  var myFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onBackground,
      appBar: AppBar(
        title: const Text('Plan Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    TextDetailsWidget(
                        labelText: "Start Date : ",
                        prefixIcon: Icons.calendar_today,
                        onTap: () => _selectDate(startdateInputController),
                        controller: startdateInputController,
                        validation: "Please select a date. "),
                    const SizedBox(
                      height: 20,
                    ),
                    TextDetailsWidget(
                        labelText: "End Date : ",
                        prefixIcon: Icons.calendar_today,
                        onTap: () => _selectDate(enddateInputController),
                        controller: enddateInputController,
                        validation: "Please select a date. "),
                    const SizedBox(
                      height: 20,
                    ),
                    budgetField(context, budgetInputController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextDetailsWidget(
                        labelText: "Start Time : ",
                        prefixIcon: Icons.access_time,
                        onTap: () => _selectTime(
                            const TimeOfDay(hour: 8, minute: 00),
                            startTimeInputController),
                        controller: startTimeInputController,
                        validation: "Please select a Time. "),
                    const SizedBox(
                      height: 20,
                    ),
                    TextDetailsWidget(
                        labelText: "End Time : ",
                        prefixIcon: Icons.access_time,
                        onTap: () => _selectTime(
                            const TimeOfDay(hour: 18, minute: 00),
                            endTimeInputController),
                        controller: endTimeInputController,
                        validation: "Please select a Time. "),
                    const SizedBox(height: 20.0),
                    TextDetailsWidget(
                        labelText: "Accomodation : ",
                        prefixIcon: Icons.hotel_rounded,
                        onTap: () => _openAccommodationDialog(context),
                        controller: hotelInputController,
                        validation: "Select a hotel")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: VisibleButton(
        colorScheme: colorScheme,
        visible: true,
        alignment: Alignment.bottomRight,
        isPop: false,
        isPush: false,
        widget: widget,
        text: "Next",
        onPressed: onPressed,
      ),
    );
  }

  void _selectDate(TextEditingController inputController) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (newDate != null) {
      inputController.text = myFormat.format(newDate);
    }
  }

  void _selectTime(
      TimeOfDay initialTime, TextEditingController inputController) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (newTime != null) {
      inputController.text =
          // ignore: use_build_context_synchronously
          newTime.format(context);
    }
  }

  void _openAccommodationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          insetPadding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: BlocBuilder<SelectHotelBloc, SelectHotelState>(
              builder: (context, state) {
                if (state.status == Status.initial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == Status.loaded) {
                  return Column(
                    children: [
                      VerticalList(
                        places: state.hotels,
                        inputController: hotelInputController,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Error Getting the hotels"),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Function()? onPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<PlanDetailsBloc>().add(GetDetails(
          startDate: startdateInputController.text,
          endDate: enddateInputController.text,
          startTime: startTimeInputController.text,
          endTime: endTimeInputController.text,
          budget: budgetInputController.text,
          hotel: (context).read<SelectHotelBloc>().state.selectedHotel));
      if (context.read<FetchPlacesBloc>().state is! FetchPlacesSuccess) {
        BlocProvider.of<FetchPlacesBloc>(context).add(
            FetchPlaces(areaName: context.read<PlanDetailsBloc>().state.area));
      }

      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const PlaceSelectionScreen();
      }));
    }

    return null;
  }

  TextFormField budgetField(
      BuildContext context, TextEditingController inputController) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: inputController,
      onChanged: (value) {
        inputController.text = value;
      },
      decoration: InputDecoration(
        labelText: 'Budget Amount', // More descriptive label
        prefixIcon: Icon(Icons.currency_rupee,
            color: Theme.of(context).colorScheme.primary),
        hintText: 'Enter your planned expense', // Placeholder text
        contentPadding:
            const EdgeInsets.all(12.0), // Generous padding for touch targets
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, // Use theme color
          ),
        ),
        errorBorder: OutlineInputBorder(
          // Style error state
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error, // Use theme color
          ),
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(
          decimal: true), // Numerical input with decimals
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Restrict to digits
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a budget amount.';
        } else if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        // Add any additional validation logic (e.g., range checking)
        return null;
      },
    );
  }
}

class VerticalList extends StatelessWidget {
  final List<Place> places;
  final TextEditingController inputController;
  const VerticalList(
      {super.key, required this.places, required this.inputController});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<SelectHotelBloc, SelectHotelState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  "Use Current location ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                tileColor: colorScheme.secondary.withOpacity(0.1),
                onTap: () async {
                  CurrentLocation()._requestLocationPermission();
                  // CurrentLocation()._getCurrentLocation();
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.best);
                  // String location_name = await CurrentLocation()
                  //     ._getAddressFromLatLng(
                  //         position.latitude, position.longitude);
                  // LatLng? current = await CurrentLocation().getLocation();
                  // log(position.longitude.toString());
                  // log(location_name.toString());
                  if (context.mounted) {
                    BlocProvider.of<SelectHotelBloc>(context).add(SelectHotel(
                        hotel: Place.withLatLong(
                      placeName: "Current Location",
                      placeImage: "",
                      latitude: position.latitude.toString(),
                      longitude: position.longitude.toString(),
                    )));
                    inputController.text = "Current Location";
                    Navigator.of(context).pop();
                  }
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                      state.selectedHotel.placeName == "Current Location"
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: colorScheme.primary,
                      size: 24),
                ),
              ),
              ListView.builder(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  Place currentPlace = places[index];
                  final isSelected = state.selectedHotel == currentPlace;
                  return VerticalPlaceItem(
                    currentPlace: currentPlace,
                    isSelected: isSelected,
                    inputController: inputController,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CurrentLocation {
  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  // Future<Position?> _getCurrentLocation() async {
  //   bool isPermissionGranted = await _requestLocationPermission();
  //   if (isPermissionGranted) {
  //     return await Geolocator.getCurrentPosition();
  //   } else {
  //     // Handle permission denied case
  //     return null;
  //   }
  // }

  // Future<String> _getAddressFromLatLng(
  //     double latitude, double longitude) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(latitude, longitude);
  //   if (placemarks.isNotEmpty) {
  //     Placemark place = placemarks[0];
  //     // Extract specific address components (e.g., locality, administrativeArea)
  //     // String address = "${place.locality}, ${place.administrativeArea}";
  //     String address = "${place.subLocality} ${place.subAdministrativeArea}";
  //     return address;
  //   } else {
  //     return "No address found";
  //   }
  // }
  // LatLng? currentlocation;
  // final Location _locationController = Location();

  // Future<LatLng?> getLocation() async {
  //   LocationData? locationData = await _locationController.getLocation();
  //   currentlocation = LatLng(locationData.latitude!, locationData.longitude!);
  //   log(currentlocation!.latitude.toString());
  //   return currentlocation;
  // }

  // Future<void> getLocationUpdates() async {
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;

  //   serviceEnabled = await _locationController.serviceEnabled();
  //   if (serviceEnabled) {
  //     serviceEnabled = await _locationController.requestService();
  //   } else {
  //     return;
  //   }

  //   permissionGranted = await _locationController.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await _locationController.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationController.onLocationChanged
  //       .listen((LocationData currentLocation) {
  //     if (currentLocation.latitude != null &&
  //         currentLocation.longitude != null) {
  //       currentlocation =
  //           LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //     }
  //   });
  // }
}

class VerticalPlaceItem extends StatelessWidget {
  final Place currentPlace;
  final bool isSelected;
  final TextEditingController inputController;
  const VerticalPlaceItem(
      {super.key,
      required this.currentPlace,
      required this.isSelected,
      required this.inputController});
  @override
  Widget build(BuildContext context) {
    String placeImage = currentPlace.placeImage;
    String placeName = currentPlace.placeName;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: SizedBox(
          height: 100.0,
          child: Row(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(placeImage,
                  height: 100.0, width: 100.0, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15.0),
            Icon(
              isSelected
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank,
              color: Theme.of(context).colorScheme.background,
              size: 30,
            ),
            const SizedBox(width: 15.0),
            Flexible(
              child: Text(
                placeName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
        ),
        onTap: () {
          BlocProvider.of<SelectHotelBloc>(context)
              .add(SelectHotel(hotel: currentPlace));
          inputController.text = currentPlace.placeName;
        },
      ),
    );
  }
}
