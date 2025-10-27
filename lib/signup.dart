
import 'package:excelerate_my_learning/mainapplication.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'mockdata.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _selectedGender;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(text: '+254');
  final TextEditingController _phoneController = TextEditingController();

  void _showAuthMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleSignUp(BuildContext context) {
// Mock user profile update with form data
    mockUserProfile.firstName = _firstNameController.text;
    mockUserProfile.lastName = _lastNameController.text;
    mockUserProfile.otherName = _otherNameController.text;
    mockUserProfile.gender = _selectedGender ?? 'Not Specified';
    mockUserProfile.email = _emailController.text;
    mockUserProfile.countryCode = _countryCodeController.text;
    mockUserProfile.phoneNumber = _phoneController.text;

    _showAuthMessage(context, 'Account created successfully! Welcome to Excelerate.');
    Navigator.pushReplacementNamed(context, '/HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ExcelerateLogo(fontSize: 40),
              const SizedBox(height: 30),

// Name Fields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: const Icon(Icons.person, color: exceleratePrimary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        prefixIcon: const Icon(Icons.person_outline, color: exceleratePrimary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _otherNameController,
                decoration: InputDecoration(
                  labelText: 'Other Name(s) (Optional)',
                  prefixIcon: const Icon(Icons.badge, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

// Gender Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: const Icon(Icons.face, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                initialValue: _selectedGender,
                hint: const Text('Select Gender'),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),

// Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

// Phone Number Fields
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: TextFormField(
                      controller: _countryCodeController, // Controller handles initial value, replacing the deprecated 'value'
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone, color: exceleratePrimary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

// Password Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 30),

// Standard Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: excelerateAccent,
                    foregroundColor: excelerateDark,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _handleSignUp(context),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),

// Divider for Social Login
              Row(
                children: [
                  const Expanded(child: Divider(color: excelerateDark)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                        'OR',
                        style: TextStyle(color: excelerateDark.withValues(alpha: 179))
                    ),
                  ),
                  const Expanded(child: Divider(color: excelerateDark)),
                ],
              ),
              const SizedBox(height: 30),

// Google Sign-Up Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
                    height: 24.0,
                    width: 24.0,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.blue, size: 30),
                  ),
                  label: const Text('Sign Up with Google', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: excelerateDark, width: 1.5),
                  ),
                  onPressed: () {
                    mockUserProfile.firstName = 'Google';
                    mockUserProfile.lastName = 'User';
                    _showAuthMessage(context, 'Signed up with Google successfully! Welcome.');
                    Navigator.pushReplacementNamed(context, '/HomeScreen');
                  },
                ),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Log In',
                  style: TextStyle(color: excelerateDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}