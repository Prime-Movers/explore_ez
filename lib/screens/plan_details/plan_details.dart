import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/screens/plan_details/place_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:explore_ez/components/visible_button.dart';

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
                    dateField(
                      context,
                      "Start Date : ",
                      startdateInputController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // End date
                    dateField(
                      context,
                      "End Date : ",
                      enddateInputController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    budgetField(context, budgetInputController),
                    const SizedBox(
                      height: 20,
                    ),

                    timeField(context, "Start Time", startTimeInputController,
                        const TimeOfDay(hour: 8, minute: 00)),

                    const SizedBox(
                      height: 20,
                    ),
                    timeField(context, "End Time", endTimeInputController,
                        const TimeOfDay(hour: 18, minute: 00)),

                    const SizedBox(height: 20.0),
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

  Function()? onPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<PlanDetailsBloc>().add(GetDetails(
          startDate: startdateInputController.text,
          endDate: enddateInputController.text,
          startTime: startTimeInputController.text,
          endTime: endTimeInputController.text,
          budget: budgetInputController.text));

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

  TextFormField dateField(BuildContext context, String labelText,
      TextEditingController inputController) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.background,
        ),
        contentPadding: const EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
        );
        if (newDate != null) {
          inputController.text = myFormat.format(newDate);
        }
      },
      // Use a more descriptive function name
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date.';
        }
        return null;
      },
    );
  }

  TextFormField timeField(BuildContext context, String labelText,
      TextEditingController inputController, TimeOfDay defaultTime) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          Icons.access_time,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.background,
        ),
        contentPadding: const EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: defaultTime,
        );
        if (newTime != null) {
          // ignore: use_build_context_synchronously
          inputController.text = newTime.format(context);
        }
      }, // Use a more descriptive function name
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date.';
        }
        return null;
      },
    );
  }
}
