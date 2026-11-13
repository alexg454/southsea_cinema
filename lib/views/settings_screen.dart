import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronNumberController;
  bool _receiveNewsletter = false;
  String _confirmationMessage = '';

  @override
    void initState() {
      super.initState();
      _nameController = TextEditingController();
      _addressController = TextEditingController();
      _emailController = TextEditingController();
      _patronNumberController = TextEditingController();
    }

    @override
    void dispose() {
      _nameController.dispose();
      _addressController.dispose();
      _emailController.dispose();
      _patronNumberController.dispose();
      super.dispose();
    }

    void _saveSettings() {
      final String name = _nameController.text.trim();
      final String address = _addressController.text.trim();
      final String email = _emailController.text.trim();
      final String patronNumber = _patronNumberController.text.trim();

      final UserSettings settings = UserSettings(
        name: name,
        address: address,
        email: email,
        patronNumber: patronNumber,
        receiveNewsletter: _receiveNewsletter,
      );

      setState(() {
        _confirmationMessage = 'Settings saved for ${settings.name}';
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Name',
              style: settingHeaderStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full name',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Address',
              style: settingHeaderStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Home address',
                hintText: 'Enter home address',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Email',
              style: settingHeaderStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Patron Number',
              style: settingHeaderStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _patronNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Patron number',
                hintText: 'Enter patron number'
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preferences',
              style: settingHeaderStyle,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(
                  child: Text('Receive newsletter and offers'),
                ),
                Switch(
                  value: _receiveNewsletter, 
                  onChanged: (bool value) {
                    setState(() {
                      _receiveNewsletter = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'SAVE SETTINGS', 
                onPressed: _saveSettings,
              ),
            ),
            if (_confirmationMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _confirmationMessage,
                style: const TextStyle(fontWeight: FontWeight.bold)
              ),
            ],
          ],
        ),
      ),
    );
  }
}