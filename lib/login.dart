import 'package:flutter/material.dart';
import 'package:excelerate_my_learning/mainapplication.dart';
import 'package:excelerate_my_learning/main.dart';
import 'package:excelerate_my_learning/mockdata.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<Map<String, String>> dummyUsers = [
    {'email': 'testuser@flutter.dev', 'password': '123456'},
    {'email': 'user@excelerate.com', 'password': 'password'},
  ];

  void _showAuthMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final userExists = dummyUsers.any((user) =>
        user['email'] == email && user['password'] == password);

    if (userExists) {
      mockUserProfile.email = email;
      Navigator.pushNamed(context, '/MfaVerificationScreen');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Access Denied'),
          content: const Text('User not found. Please sign up to access the app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/SignUpScreen');
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ExcelerateLogo(fontSize: 50),
              const Text(
                'Excelerate Your Learning',
                style: TextStyle(
                  color: excelerateDark,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 60),

              // Email Field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: exceleratePrimary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: exceleratePrimary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: exceleratePrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleLogin,
                  child: const Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/MfaVerificationScreen');
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: exceleratePrimary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: excelerateDark)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: excelerateDark.withAlpha(179)),
                    ),
                  ),
                  const Expanded(child: Divider(color: excelerateDark)),
                ],
              ),
              const SizedBox(height: 30),

              // Google Sign-In
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
                    height: 24.0,
                    width: 24.0,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.g_mobiledata, color: Colors.blue, size: 30),
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: excelerateDark, width: 1.5),
                  ),
                  onPressed: () {
                    mockUserProfile.firstName = 'Google';
                    mockUserProfile.lastName = 'User';
                    _showAuthMessage(context, 'Signed in with Google successfully!');
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up Navigation
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SignUpScreen');
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: excelerateDark, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}