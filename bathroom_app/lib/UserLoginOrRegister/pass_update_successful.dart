import 'package:bathroom_app/Dashboard/main_dashboard_map.dart';
import 'package:flutter/material.dart';

class HuzzahPage extends StatefulWidget {
  const HuzzahPage({super.key});

  @override
  State<HuzzahPage> createState() => _HuzzahPageState();
}

class _HuzzahPageState extends State<HuzzahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 160,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color.fromARGB(255, 26, 130, 195)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
            const SizedBox(height: 100),
            const Text(
              'Huzzah!',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Password has been successfully updated!',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DashboardMap()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 26, 130, 195),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
