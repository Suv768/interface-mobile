import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  String name;
  bool done;
  Timestamp date;

  Reminder({this.name, this.done, this.date});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      name: json['name'] as String,
      done: json['done'] as bool,
      date: json['date'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _ReminderToJson(this);

  Map<String, dynamic> _ReminderToJson(Reminder instance) => <String, dynamic>{
        'name': instance.name,
        'done': instance.done,
        'date': instance.date,
      };
}
