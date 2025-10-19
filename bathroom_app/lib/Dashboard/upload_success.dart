import 'package:flutter/material.dart';
import 'package:bathroom_app/Dashboard/main_dashboard_map.dart';

class UploadSuccessPage extends StatefulWidget {
  const UploadSuccessPage({Key? key}) : super(key: key);

  @override
  State<UploadSuccessPage> createState() => UploadSuccessPageState();
}

class UploadSuccessPageState extends State<UploadSuccessPage> {
  bool _buttonVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'woo hoo!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your uploaded bathroom will be under review. '
                  'We will notify you if ever it will be approved according to our policies.\n'
                  'Thanks for contributing!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (_buttonVisible)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _buttonVisible = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const DashboardMap(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 26, 130, 195),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Great!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
