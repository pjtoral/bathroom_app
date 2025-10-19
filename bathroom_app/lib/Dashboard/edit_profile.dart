import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Initial saved values
  static String savedBio = 'I love going into bathrooms!';
  static String savedUsername = 'Stefen';
  static String savedPassword = 'Password';

  late TextEditingController _bioController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: savedBio);
    _usernameController = TextEditingController(text: savedUsername);
    _passwordController = TextEditingController(text: savedPassword);
  }

  void _saveChanges() {
    setState(() {
      savedBio = _bioController.text;
      savedUsername = _usernameController.text;
      savedPassword = _passwordController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const orangeBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color.fromARGB(255, 26, 130, 195)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 26, 130, 195),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // Profile picture with white-bordered gray edit icon
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFFD9D9D9),
                        radius: 16,
                        child: Icon(Icons.edit, size: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Bio
            const Text('Bio', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextField(
              controller: _bioController,
              maxLength: 200,
              maxLines: 4,
              decoration: InputDecoration(
                border: orangeBorder,
                focusedBorder: orangeBorder,
                contentPadding: const EdgeInsets.all(12),
              ),
            ),

            const SizedBox(height: 16),

            // Username
            const Text('Username', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: orangeBorder,
                focusedBorder: orangeBorder,
                contentPadding: const EdgeInsets.all(12),
              ),
            ),

            const SizedBox(height: 16),

            // Password
            const Text('Password', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                border: orangeBorder,
                focusedBorder: orangeBorder,
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 26, 130, 195),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Save Changes button
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 26, 130, 195),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
