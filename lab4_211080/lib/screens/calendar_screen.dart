import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:lab4_211080/models/event.dart";
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  final List<Event> events;

  const CalendarScreen({super.key, required this.events});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<String, List<Event>> _events = {};
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _prepareEvents();
  }

  Future<void> _prepareEvents() async {
    Map<String, List<Event>> eventsMap = {};

    for (var event in widget.events) {
      var date = DateTime(
          event.dateTime.year, event.dateTime.month, event.dateTime.day);
      var dateKey = date.toIso8601String().substring(0, 10);

      if (!eventsMap.containsKey(dateKey)) {
        eventsMap[dateKey] = [];
      }
      eventsMap[dateKey]!.add(event);
    }

    setState(() {
      _events = eventsMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Schedule')),
      body: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime(_focusedDay.year, _focusedDay.month - 1, 1),
        lastDay: DateTime(_focusedDay.year, _focusedDay.month + 1, 0),
        calendarFormat: CalendarFormat.month,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });

          var dateKey = selectedDay.toIso8601String().substring(0, 10);
          var events = _events[dateKey] ?? [];

          if (events.isNotEmpty) {
            _showEventDetailsPopup(context, events);
          }
        },
        eventLoader: (day) {
          var dateKey = day.toIso8601String().substring(0, 10);
          return _events[dateKey] ?? [];
        },
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }

  void _showEventDetailsPopup(BuildContext context, List<Event> events) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Events on Selected Date'),
          content: SingleChildScrollView(
            child: Column(
              children: events.map((event) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject: ${event.name}',
                      ),
                      Text(
                        'Time: ${DateFormat('HH:mm').format(event.dateTime)}',
                      ),
                      Text(
                        'Location: ${event.latitude}, ${event.longitude}',
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location(
      {required this.name, required this.latitude, required this.longitude});
}
