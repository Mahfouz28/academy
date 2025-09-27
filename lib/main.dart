import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://abvugltypdgkqsqdmgkz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFidnVnbHR5cGRna3FzcWRtZ2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4ODY5NTIsImV4cCI6MjA3NDQ2Mjk1Mn0.2IRlSge715lz9v8eGoU3uQQRHAmmJ_PCuNNObwumIoA',
  );

  runApp(const MyApp());
}
