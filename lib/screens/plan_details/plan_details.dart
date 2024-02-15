import 'package:flutter/material.dart';
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
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String budget = "";
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  TextEditingController startdateInputController = TextEditingController();
  TextEditingController enddateInputController = TextEditingController();
  TextEditingController startTimeInputController = TextEditingController();
  TextEditingController endTimeInputController = TextEditingController();
  var myFormat = DateFormat('d-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onBackground,
      appBar: AppBar(
        title: Text('Plan Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
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
                      () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        if (newDate != null) {
                          startdateInputController.text =
                              myFormat.format(newDate);
                          setState(() {
                            _startDate = newDate;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // End date
                    dateField(
                      context,
                      "End Date : ",
                      enddateInputController,
                      () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        if (newDate != null) {
                          enddateInputController.text =
                              myFormat.format(newDate);
                          setState(() {
                            _endDate = newDate;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    budgetField(context),
                    const SizedBox(
                      height: 20,
                    ),

                    timeField(context, "Start Time", startTimeInputController,
                        startTime),

                    const SizedBox(
                      height: 20,
                    ),
                    timeField(
                        context, "End Time", endTimeInputController, endTime),

                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField budgetField(BuildContext context) {
    return TextFormField(
      onChanged: (value) => budget = value,
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
      TextEditingController inputController, Function()? onTap) {
    return TextFormField(
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
      onTap: onTap,
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
      TextEditingController inputController, TimeOfDay currentTime) {
    return TextFormField(
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
          initialTime: currentTime,
        );
        if (newTime != null) {
          // ignore: use_build_context_synchronously
          inputController.text = newTime.format(context);
          setState(() {
            currentTime = newTime;
          });
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
