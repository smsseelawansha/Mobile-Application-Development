import 'package:budget_buddy/pages/todo/buttons.dart';
import 'package:budget_buddy/pages/todo/input.dart';
import 'package:budget_buddy/pages/todo/task_display_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({Key? key}) : super(key: key);

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTIme = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectRemind = 5;
  List<int> reminderList = [
    5,
    10,
    15,
    20,
  ];
  String _selectRepeat = 'None';
  List<String> repatList = [
    'None',
    'Daily',
    'Weekly',
    'Yearly',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text(
                  "Add Task!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Input_Field(
                  title: "Title",
                  hint: "Enter your title",
                  controller: _titleController),
              Input_Field(
                title: "Note",
                hint: "Enter your note",
                controller: _noteController,
              ),
              Input_Field(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                  onPressed: () {
                    _getDateuser(context); 
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Input_Field(
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )),
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Input_Field(
                    title: "End Time",
                    hint: _endTIme,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )),
                  )),
                ],
              ),
              Input_Field(
                title: "Remind",
                hint: "$_selectRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRemind = int.parse(newValue!);
                    });
                  },
                  items:
                      reminderList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              Input_Field(
                title: "Repeat",
                hint: "$_selectRepeat",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  elevation: 4,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRepeat = newValue!;
                    });
                  },
                  items:
                      repatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Buttons(
                      label: "Create Task",
                      onTap: () => _validdata(),
                      OnTap: () {},
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }

 _validdata() {
  if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
    Get.snackbar("Required", "All fields are required!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red));
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetails(
          title: _titleController.text,
          note: _noteController.text,
          selectedDate: _selectedDate,
          startTime: _startTime,
          endTime: _endTIme,
          selectedRemind: _selectRemind,
          selectedRepeat: _selectRepeat,
        ),
      ),
    );
  }
}


  

  _getDateuser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2016),
      lastDate: DateTime(2028),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });

      // ignore: unnecessary_null_comparison
      if (_pickerDate != null) {
        setState(() {
          _selectedDate = _pickerDate;
          print(_selectedDate);
        });
      } else {
        print("Something wrong!");
      }
    }
  }

  _getTimeUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Out");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTIme = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split("")[0]),
        ));
  }
}
