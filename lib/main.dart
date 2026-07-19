import 'dart:io';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart'; 

void main() => runApp(
  const MaterialApp(
    home: MapNavigationScreen(),
    debugShowCheckedModeBanner: false,
  ),
);

class MapNavigationScreen extends StatefulWidget {
  const MapNavigationScreen({super.key});
  @override
  State<MapNavigationScreen> createState() => _MapNavigationScreenState();
}

class _MapNavigationScreenState extends State<MapNavigationScreen> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  Future<void> _launchMapsIntent() async {
    final from = _fromController.text.trim();
    final to = _toController.text.trim();
    if (from.isEmpty || to.isEmpty) return;

    if (Platform.isAndroid) {
      // গুগল ম্যাপস ইউআরএল ফরম্যাট
      final mapsUrl =
          'https://www.google.com/maps/dir/?api=1&origin=${Uri.encodeComponent(from)}&destination=${Uri.encodeComponent(to)}&travelmode=driving';

      // {Link: android_intent_plus usage example https://pub.dev/packages/android_intent_plus/example}
      final intent = AndroidIntent(
        action: 'action_view',
        data: mapsUrl,
        package: 'com.google.android.apps.maps',
      );
      if (await intent.canResolveActivity() ?? false) await intent.launch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Direction Finder'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _fromController,
              decoration: const InputDecoration(labelText: 'From'),
            ),
            TextField(
              controller: _toController,
              decoration: const InputDecoration(labelText: 'To'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchMapsIntent,
              child: const Text('Find Direction'),
            ),
          ],
        ),
      ),
    );
  }
}
