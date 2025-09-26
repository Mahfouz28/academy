import 'package:academy/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  String _beltLevel = 'White';
  String _subscriptionStatus = 'pending';

  final List<String> beltLevels = [
    'White',
    'Yellow',
    'Orange',
    'Green',
    'Blue',
    'Brown',
    'Black',
  ];

  final List<String> subscriptionStatuses = ['pending', 'active', 'expired'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, 'Name'),
              const SizedBox(height: 16),
              _buildTextField(
                _phoneController,
                'Phone',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _ageController,
                'Age',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildDropdown('Belt Level', _beltLevel, beltLevels, (val) {
                setState(() {
                  _beltLevel = val!;
                });
              }),
              const SizedBox(height: 16),
              _buildDropdown(
                'Subscription Status',
                _subscriptionStatus,
                subscriptionStatuses,
                (val) {
                  setState(() {
                    _subscriptionStatus = val!;
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
                  if (_formKey.currentState!.validate()) {
                    // TODO: Call Supabase function here
                    print('Name: ${_nameController.text}');
                    print('Phone: ${_phoneController.text}');
                    print('Age: ${_ageController.text}');
                    print('Belt: $_beltLevel');
                    print('Subscription: $_subscriptionStatus');
                  }
                },
                child: const Text('Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
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

  Widget _buildDropdown(
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
