import 'package:mental_health/screens/patient_dashboard/training/models/course.dart';
import 'package:mental_health/screens/patient_dashboard/training/models/style.dart';

final _standStyle = Style(
  link: 'https://www.youtube.com/watch?v=KYbFGbLPlb0',
  imageUrl: 'assets/images/pose2.png',
  name: 'Standing Style',
  time: 15,
);
final _sittingStyle = Style(
  link: 'https://www.youtube.com/watch?v=jQcefAEtXeU',
  imageUrl: 'assets/images/pose1.png',
  name: 'Sitting Style',
  time: 10,
);
final _legCrossStyle = Style(
  link: 'https://www.youtube.com/watch?v=IGQgt3eHoRc',
  imageUrl: 'assets/images/pose3.png',
  name: 'Stress Relief',
  time: 21,
);
final styles = [_standStyle, _sittingStyle, _legCrossStyle];

final _course1 = Course(
    link: 'https://www.youtube.com/watch?v=7QjeHwFnyI4',
    imageUrl: 'assets/images/course5.jpg',
    name: 'Cardio Exercises',
    time: 20,
    students: 'Beginner');

final _course2 = Course(
    imageUrl: 'assets/images/course4.jpg',
    name: 'Exercises to feel Good',
    time: 23,
    students: 'Beginner',
    link: 'https://www.youtube.com/watch?v=m1DBJhxKmiU');

final _course3 = Course(
    imageUrl: 'assets/images/course3.jpg',
    name: 'Meditation to find Peace',
    time: 15,
    students: 'Beginner',
    link: 'https://www.youtube.com/watch?v=W19PdslW7iw');

final _course4 = Course(
    imageUrl: 'assets/images/course2.jpg',
    name: 'Daily Yoga',
    time: 15,
    students: 'Intermediate',
    link: 'https://www.youtube.com/watch?v=brjAjq4zEIE');

final _course5 = Course(
    imageUrl: 'assets/images/course1.jpg',
    name: 'Advance Stretching',
    time: 30,
    students: 'Advanced',
    link: 'https://www.youtube.com/watch?v=xPUCPzyOvnw');

final List<Course> courses = [_course1, _course3, _course2, _course4, _course5];
