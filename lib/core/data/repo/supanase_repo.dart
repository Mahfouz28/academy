import 'package:academy/features/students/data/models/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupanaseRepo {
  final student = Student;
  final supabase = Supabase.instance.client;
  // to add new student
  Future<String?> insertStudent({
    required String name,
    required String phone,
    required int age,
    required String beltLevel,
    required String subscriptionStatus,
  }) async {
    try {
      final response = await supabase.rpc(
        'insert_student',
        params: {
          'p_name': name,
          'p_phone': phone,
          'p_age': age,
          'p_belt_level': beltLevel,
          'p_subscription_status': subscriptionStatus,
        },
      );

      return response as String?;
    } catch (e) {
      print('Error inserting student: $e');
      return null;
    }
  }

  // to get all student
  Future<List<Student>> getStudents() async {
    final student = await supabase
        .from('students')
        .select()
        .order('created_at');

    return student.map((e) => Student.fromJson(e)).toList();
  }

  //Delete Student
  Future<void> deleteStudent(String id) async {
    await supabase.from('students').delete().eq('id', id);
  }

  Future<void> updateStudent(Student student) async {
    await supabase
        .from('students')
        .update({
          'name': student.name,
          'phone': student.phone,
          'age': student.age,
          'belt_level': student.beltLevel,
          'subscription_status': student.subscriptionStatus,
        })
        .eq('id', student.id);
  }

  //? serche
  Future<List<Student>> searchStudents(String query) async {
    final response =
        await supabase
                .from('students')
                .select()
                .or(
                  'name.ilike.%$query%,phone.ilike.%$query%,subscription_status.ilike.%$query%,belt_level.ilike.%$query%',
                )
            as List<dynamic>;

    final data = response;
    return data.map((e) => Student.fromJson(e)).toList();
  }
}
