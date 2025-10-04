import 'package:academy/core/helpers/snack_bar_helper.dart';
import 'package:academy/features/students/data/models/student_model.dart';
import 'package:academy/features/students/logic/cubit/student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditStudentDialog extends StatefulWidget {
  final Student student;

  const EditStudentDialog({super.key, required this.student});

  @override
  State<EditStudentDialog> createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends State<EditStudentDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late String beltLevel;
  late String subscriptionStatus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    phoneController = TextEditingController(text: widget.student.phone);
    ageController = TextEditingController(text: widget.student.age.toString());
    beltLevel = widget.student.beltLevel;
    subscriptionStatus = widget.student.subscriptionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Student"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            16.verticalSpace,
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            16.verticalSpace,
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            16.verticalSpace,
            DropdownButtonFormField<String>(
              initialValue: beltLevel,
              decoration: const InputDecoration(labelText: "Belt Level"),
              items:
                  [
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
                      ]
                      .map(
                        (level) =>
                            DropdownMenuItem(value: level, child: Text(level)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => beltLevel = value!),
            ),
            16.verticalSpace,
            DropdownButtonFormField<String>(
              initialValue: subscriptionStatus,
              decoration: const InputDecoration(
                labelText: "Subscription Status",
              ),
              items: ["pending", "active", "expired"]
                  .map(
                    (status) =>
                        DropdownMenuItem(value: status, child: Text(status)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => subscriptionStatus = value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedStudent = widget.student.copyWith(
              name: nameController.text,
              phone: phoneController.text,
              age: int.tryParse(ageController.text) ?? widget.student.age,
              beltLevel: beltLevel,
              subscriptionStatus: subscriptionStatus,
            );

            context.read<StudentCubit>().updateStudent(updatedStudent);

            Navigator.pop(context);

            SnackBarHelper.show(
              context,
              'Student updated successfully!',
              type: SnackBarType.success,
            );
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}
