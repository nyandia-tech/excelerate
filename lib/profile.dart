import 'package:excelerate_my_learning/main.dart';
import 'package:excelerate_my_learning/mockdata.dart';
import 'package:flutter/material.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: excelerateDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: excelerateAccent,
              child: Text(
                mockUserProfile.fullName.substring(0, 1),
                style: const TextStyle(fontSize: 40, color: excelerateDark, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              mockUserProfile.fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: excelerateDark),
            ),
            const SizedBox(height: 30),

// User Details Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: exceleratePrimary),
              ),
            ),
            const Divider(color: excelerateDark),
            _buildProfileDetail(context, Icons.email, 'Email', mockUserProfile.email),
            _buildProfileDetail(context, Icons.phone, 'Phone', '${mockUserProfile.countryCode} ${mockUserProfile.phoneNumber}'), // Kept interpolation for formatting
            _buildProfileDetail(context, Icons.person_outline, 'Gender', mockUserProfile.gender),
            _buildProfileDetail(context, Icons.badge, 'Other Name(s)', mockUserProfile.otherName.isEmpty ? 'N/A' : mockUserProfile.otherName),

            const SizedBox(height: 50),

// Log Out Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Log Out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: exceleratePrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _handleLogout(context),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _showSimpleMessage(context, 'Edit Profile', 'Simulating navigation to profile edit page.');
              },
              child: const Text('Edit Profile Details', style: TextStyle(color: excelerateDark)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: exceleratePrimary, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: excelerateDark.withValues(alpha: 153)),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: excelerateDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Log Out'),
        content: const Text('Are you sure you want to log out of your Excelerate account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: excelerateDark)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
// Navigate back to login screen, removing all previous routes
              Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen', (route) => false);
            },
            child: const Text('Log Out', style: TextStyle(color: exceleratePrimary)),
          ),
        ],
      ),
    );
  }

  void _showSimpleMessage(BuildContext context, String title, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: excelerateAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}