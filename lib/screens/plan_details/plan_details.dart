import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanDetails extends StatefulWidget {
  const PlanDetails({super.key});

  @override
  State<PlanDetails> createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> {
  final _formKey = GlobalKey<FormState>(); // for form validation
  DateTime _startDate = DateTime.now(); // initial start date
  DateTime _endDate = DateTime.now(); // initial end date
  String _budget = ""; // initial description
  TimeOfDay _startTime = TimeOfDay.now(); // initial start time
  TimeOfDay _endTime = TimeOfDay.now(); // initial end time
  TextEditingController StartdateInputController = TextEditingController();
  TextEditingController EnddateInputController = TextEditingController();
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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Start date
              TextField(
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  icon: Icon(Icons.calendar_today),
                  hintText: "Enter Start Date",
                  hintStyle: TextStyle(color: colorScheme.background),
                ),
                readOnly: true,
                controller: StartdateInputController, // show date picker on tap
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                  );
                  if (newDate != null) {
                    StartdateInputController.text = myFormat.format(newDate);
                    setState(() {
                      _startDate = newDate;
                    });
                  }
                },
              ),

              // End date
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  icon: Icon(Icons.calendar_today),
                ),
                controller: EnddateInputController,
                readOnly: true, // show date picker on tap
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _endDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                  );
                  if (newDate != null) {
                    EnddateInputController.text = myFormat.format(newDate);
                    setState(() {
                      _endDate = newDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end date.';
                  }
                  return null;
                },
              ),

              // Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'budget',
                ),
                onChanged: (value) {
                  setState(() {
                    _budget = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),

              // Start time
              Row(
                children: [
                  Text('Start Time:'),
                  SizedBox(width: 10.0),
                  Text(
                    _startTime.format(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: _startTime,
                      );
                      if (newTime != null) {
                        setState(() {
                          _startTime = newTime;
                        });
                      }
                    },
                  ),
                ],
              ),

              // End time
              Row(
                children: [
                  Text('End Time:'),
                  SizedBox(width: 10.0),
                  Text(
                    _endTime.format(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: _endTime,
                      );
                      if (newTime != null) {
                        setState(() {
                          _endTime = newTime;
                        });
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                    print('Plan details:');
                    print(
                        'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}');
                    print(
                        'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate)}');
                    print('Description: $_budget');
                    print('Start Time: $_startTime');
                    print('End Time: $_endTime');

                    // You can now do something with the collected data,
                    // such as storing it in a database or sending it to a server.

                    // For example, you could navigate to a new page:
                    Navigator.pushNamed(context, '/plan_confirmation');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
