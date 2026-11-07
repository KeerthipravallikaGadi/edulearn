# EduLearn - Online Learning Platform

A fully responsive online learning website built with **Flutter Web** and **Dart** as an External Lab Project.
Users can browse courses, search and filter them, sign up / log in, enroll, and track lesson progress.

**Live demo:** `https://<your-username>.github.io/edulearn/`  *(replace after deployment)*

## Features
- Modern landing page: hero, categories, featured courses, testimonials, call-to-action
- Responsive layout for mobile, tablet and desktop (navbar becomes a drawer on small screens)
- Course catalogue with live search, category filter chips and sorting
- Course detail page with outcomes, description and curriculum
- Sign up / Login with form validation and error handling
- Enroll in courses; mark lessons complete; progress bars
- Personal dashboard with stats, enrolled courses and recommendations
- About and Contact pages (validated contact form, stored in browser storage)
- Hover animations, page fade transitions, 404 page

## Technologies Used
| Area | Technology |
|---|---|
| Framework | Flutter (Web) |
| Language | Dart |
| State management | `ChangeNotifier` + `ListenableBuilder` (built in) |
| Storage | `shared_preferences` (browser localStorage) |
| Navigation | Named routes with `onGenerateRoute` |
| Hosting | GitHub Pages / Firebase Hosting |

## Project Structure
```
lib/
  main.dart               # entry point, loads saved data
  app.dart                # MaterialApp + route table
  core/                   # theme, responsive breakpoints, validators
  models/course.dart      # Course and Lesson classes
  data/course_data.dart   # sample course data
  services/app_state.dart # auth, enrollment, progress (ChangeNotifier)
  widgets/                # navbar/footer shell, course card, layout helpers
  screens/                # home, courses, course detail, auth, dashboard, about, contact
```

## Run Locally
```bash
flutter --version          # Flutter 3.16+ recommended
flutter create . --platforms web   # generates the web/ folder (keeps lib/ and pubspec.yaml)
flutter pub get
flutter run -d chrome
```
> After `flutter create .`, delete `test/widget_test.dart` (it is the default counter test).

## Build for Production
```bash
flutter build web --release
```
Output is in `build/web`.

## Limitations
This is a front-end project without a server. Accounts, enrollments and messages are stored in the
browser's localStorage, so they exist only on that device/browser. Passwords are only obfuscated and
a real product must use a backend (e.g. Firebase Auth).
