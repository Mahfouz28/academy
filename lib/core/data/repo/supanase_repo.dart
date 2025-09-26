import 'package:supabase_flutter/supabase_flutter.dart';

class SupanaseRepo {
  final supabase = Supabase.instance.client;

  Future<String?> insertStudent({
    required String name,
    String? phone,
    required int age,
    String beltLevel = 'White',
    String subscriptionStatus = 'pending',
  }) async {
    final response = await supabase.rpc(
      'insert_student', // Name of the function in Supabase
      params: {
        'p_name': name,
        'p_phone': phone,
        'p_age': age,
        'p_belt_level': beltLevel,
        'p_subscription_status': subscriptionStatus,
      },
    );

    if (response.error != null) {
      print('Error inserting student: ${response.error!.message}');
      return null;
    }

    return response.data as String?;
  }
}
