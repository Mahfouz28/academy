import 'package:academy/core/helpers/snack_bar_helper.dart';
import 'package:academy/core/themes/app_color.dart';
import 'package:academy/features/students/logic/cubit/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => AddStudentState();
}

class AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  String beltLevel = 'White';
  String subscriptionStatus = 'pending';

  final List<String> beltLevels = [
    "White",
    "Yellow",
    "Yellow 2",
    "Orange",
    "Orange 2",
    "Green",
    "Green 2",
    "Blue",
    "Blue 2",
    "Brown",
    "Brown 2",
    "Black",
  ];

  final List<String> subscriptionStatuses = ['pending', 'active', 'expired'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text('Add Student')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  buildTextField(nameController, 'Name'),
                  const SizedBox(height: 16),
                  buildTextField(
                    phoneController,
                    'Phone',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    ageController,
                    'Age',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  buildDropdown('Belt Level', beltLevel, beltLevels, (val) {
                    setState(() {
                      beltLevel = val!;
                    });
                  }),
                  const SizedBox(height: 16),
                  buildDropdown(
                    'Subscription Status',
                    subscriptionStatus,
                    subscriptionStatuses,
                    (val) {
                      setState(() {
                        subscriptionStatus = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.accentForeground,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<StudentCubit>().addStudent(
                          nameController.text,
                          phoneController.text,
                          int.parse(ageController.text),
                          beltLevel,
                          subscriptionStatus,
                        );
                        print("Button clicked");
                      }
                    },
                    child: const Text('Add Student'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is Addsuccess) {
          Navigator.of(context, rootNavigator: true).pop(); // يقفل الـ Dialog
          SnackBarHelper.show(
            context,
            'Student added successfully!',
            type: SnackBarType.success,
          );
          nameController.clear();
          phoneController.clear();
          ageController.clear();
          setState(() {
            beltLevel = 'White';
            subscriptionStatus = 'pending';
          });
        } else if (state is AddFailure) {
          Navigator.of(context, rootNavigator: true).pop(); // يقفل الـ Dialog
          SnackBarHelper.show(context, state.error, type: SnackBarType.error);
        }
      },
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.foreground),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.mutedForeground),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        if (label == 'Age' && int.tryParse(value) == null) {
          return 'Age must be a number';
        }
        return null;
      },
    );
  }

  Widget buildDropdown(
    String label,
    String currentValue,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.mutedForeground),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          dropdownColor: AppColors.card,
          style: const TextStyle(color: AppColors.foreground),
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
