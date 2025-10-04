import 'package:academy/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectBeltLevel extends StatefulWidget {
  const SelectBeltLevel({super.key});

  @override
  _SelectBeltLevelState createState() => _SelectBeltLevelState();
}

class _SelectBeltLevelState extends State<SelectBeltLevel> {
  final List<String> items = [
    'All',
    'white',
    'yellow',
    'orange',
    'green',
    'blue',
    'brown',
    'black',
  ];

  String? selectedValue = 'All';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Text(
          'Select Belt Level',
          style: TextStyle(color: Colors.white),
        ),
        value: selectedValue,
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;

            if (value == 'All') {
              context.read<DashboardCubit>().getAllStudents();
            } else {
              context.read<DashboardCubit>().filterStudentsByBelt(value!);
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF1A1D2E),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF0E1320),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 24,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 40,
          overlayColor: WidgetStateProperty.all(Colors.amber.withOpacity(0.2)),
        ),
      ),
    );
  }
}
