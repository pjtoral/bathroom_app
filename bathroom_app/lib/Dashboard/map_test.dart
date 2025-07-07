import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'main_dashboard_searchArea.dart'; 

class DashboardMapTest extends StatefulWidget {
  const DashboardMapTest({super.key});

  @override
  State<DashboardMapTest> createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMapTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         Container(
          color: Colors.blue[200],
          child: const Center(
            child: Text("Map placeholder", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
          const DraggablePanel(),
        ],
      ),
    );
  }
}
