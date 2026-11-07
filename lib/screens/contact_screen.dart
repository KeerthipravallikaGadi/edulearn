import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../core/validators.dart';
import '../services/app_state.dart';
import '../widgets/layout.dart';
import '../widgets/page_scaffold.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static const _subjects = [
    'General Enquiry',
    'Course Support',
    'Technical Issue',
    'Feedback',
  ];

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  String _subject = _subjects.first;
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    await AppState.instance
        .saveMessage(_name.text.trim(), _email.text.trim(), _subject, _message.text.trim());
    if (!mounted) return;
    setState(() => _sending = false);
    final name = _name.text.trim();
    _formKey.currentState!.reset();
    _name.clear();
    _email.clear();
    _message.clear();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 48),
        title: const Text('Message sent!'),
        content: Text('Thank you, $name. We will get back to you within 24 hours.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Get in touch',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
        SizedBox(height: 12),
        Text('Have a question about a course or your account? Send us a message.',
            style: TextStyle(color: AppColors.text, height: 1.5)),
        SizedBox(height: 24),
        _InfoRow(Icons.email_outlined, 'support@edulearn.example'),
        _InfoRow(Icons.phone_outlined, '+91 98765 43210'),
        _InfoRow(Icons.location_on_outlined, 'Hyderabad, Telangana, India'),
        _InfoRow(Icons.access_time, 'Mon - Sat, 9 AM - 6 PM'),
      ],
    );

    final form = Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 24,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _name,
              validator: Validators.name,
              decoration: const InputDecoration(
                  labelText: 'Your name', prefixIcon: Icon(Icons.person_outline)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _email,
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _subject,
              decoration: const InputDecoration(
                  labelText: 'Subject', prefixIcon: Icon(Icons.topic_outlined)),
              items: [
                for (final s in _subjects)
                  DropdownMenuItem(value: s, child: Text(s)),
              ],
              onChanged: (v) => setState(() => _subject = v ?? _subject),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _message,
              validator: Validators.message,
              maxLines: 5,
              decoration: const InputDecoration(
                  labelText: 'Message', alignLabelWithHint: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _sending ? null : _submit,
              icon: _sending
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.send),
              label: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );

    return PageScaffold(
      child: PageSection(
        child: mobile
            ? Column(children: [info, const SizedBox(height: 32), form])
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: info),
                  const SizedBox(width: 48),
                  Expanded(child: form),
                ],
              ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
