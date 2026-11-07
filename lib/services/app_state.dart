import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/course_data.dart';
import '../models/course.dart';

/// Single source of truth for login session, enrollments and progress.
/// Data is stored in the browser (localStorage) via shared_preferences,
/// so no backend is needed. Screens rebuild through ListenableBuilder.
class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  late SharedPreferences _prefs;
  Map<String, dynamic> _users = {};
  String? _currentEmail;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs.getString('users');
    if (raw != null) {
      _users = Map<String, dynamic>.from(jsonDecode(raw) as Map);
    }
    final session = _prefs.getString('session');
    if (session != null && _users.containsKey(session)) {
      _currentEmail = session;
    }
  }

  // ---------------- Authentication ----------------

  bool get isLoggedIn => _currentEmail != null;

  String get userName {
    if (_currentEmail == null) return '';
    return (_users[_currentEmail]['name'] ?? '') as String;
  }

  String get firstName {
    final parts = userName.trim().split(' ');
    return parts.isEmpty ? '' : parts.first;
  }
    String get userEmail => _currentEmail ?? '';

  // NOTE: demo-only obfuscation. A real app must hash passwords on a server.
  String _encode(String password) =>
      base64Encode(utf8.encode('edulearn::$password'));

  Future<String?> register(String name, String email, String password) async {
    final key = email.trim().toLowerCase();
    if (_users.containsKey(key)) {
      return 'An account with this email already exists. Please log in.';
    }
    _users[key] = {'name': name.trim(), 'password': _encode(password)};
    await _prefs.setString('users', jsonEncode(_users));
    await _startSession(key);
    return null;
  }

  Future<String?> login(String email, String password) async {
    final key = email.trim().toLowerCase();
    final user = _users[key];
    if (user == null) return 'No account found for this email. Please sign up.';
    if (user['password'] != _encode(password)) return 'Incorrect password.';
    await _startSession(key);
    return null;
  }

  Future<void> _startSession(String key) async {
    _currentEmail = key;
    await _prefs.setString('session', key);
    notifyListeners();
  }

  Future<void> logout() async {
    _currentEmail = null;
    await _prefs.remove('session');
    notifyListeners();
  }

  // ---------------- Enrollment & progress ----------------

  List<String> get enrolledIds => isLoggedIn
      ? (_prefs.getStringList('enrolled_$_currentEmail') ?? <String>[])
      : <String>[];

  List<String> get _doneLessons => isLoggedIn
      ? (_prefs.getStringList('done_$_currentEmail') ?? <String>[])
      : <String>[];

  bool isEnrolled(String courseId) => enrolledIds.contains(courseId);

  Future<void> enroll(String courseId) async {
    if (!isLoggedIn || isEnrolled(courseId)) return;
    await _prefs.setStringList(
        'enrolled_$_currentEmail', [...enrolledIds, courseId]);
    notifyListeners();
  }

  bool isLessonDone(String courseId, int index) =>
      _doneLessons.contains('$courseId:$index');

  Future<void> toggleLesson(String courseId, int index) async {
    if (!isLoggedIn) return;
    final list = [..._doneLessons];
    final key = '$courseId:$index';
    if (list.contains(key)) {
      list.remove(key);
    } else {
      list.add(key);
    }
    await _prefs.setStringList('done_$_currentEmail', list);
    notifyListeners();
  }

  int completedCount(Course c) {
    var n = 0;
    for (var i = 0; i < c.lessons.length; i++) {
      if (isLessonDone(c.id, i)) n++;
    }
    return n;
  }

  double progress(Course c) =>
      c.lessons.isEmpty ? 0 : completedCount(c) / c.lessons.length;

  List<Course> get enrolledCourses =>
      courses.where((c) => enrolledIds.contains(c.id)).toList();

  int get totalCompleted => _doneLessons.length;

  double get averageProgress {
    final list = enrolledCourses;
    if (list.isEmpty) return 0;
    return list.map(progress).reduce((a, b) => a + b) / list.length;
  }

  // ---------------- Contact form ----------------

  Future<void> saveMessage(
      String name, String email, String subject, String message) async {
    final list = _prefs.getStringList('messages') ?? <String>[];
    list.add(jsonEncode({
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'time': DateTime.now().toIso8601String(),
    }));
    await _prefs.setStringList('messages', list);
  }
}
