import 'package:flutter/material.dart';
import 'main.dart';
class MfaVerificationScreen extends StatelessWidget {
  const MfaVerificationScreen({super.key});

  void _showAuthMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MFA Verification'),
        backgroundColor: excelerateDark,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.security, size: 80, color: exceleratePrimary),
              const SizedBox(height: 20),
              const Text(
                'Two-Factor Authentication',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter the 6-digit code sent to your registered email or authenticator app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: excelerateDark.withValues(alpha: 204)),
              ),
              const SizedBox(height: 40),

// Code Input Field
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 10),
                decoration: InputDecoration(
                  hintText: '• • • • • •',
                  counterText: "",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: exceleratePrimary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),

// Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: exceleratePrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    _showAuthMessage(context, 'Verification successful. Welcome!');
                    Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
                  },
                  child: const Text('Verify and Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _showAuthMessage(context, 'New code requested. Check your email.', success: false);
                },
                child: const Text(
                  'Resend Code',
                  style: TextStyle(color: excelerateDark, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}