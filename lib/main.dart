import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MiniFormPage(),
    );
  }
}

class MiniFormPage extends StatefulWidget {
  const MiniFormPage({super.key});

  @override
  State<MiniFormPage> createState() => _MiniFormPageState();
}

class _MiniFormPageState extends State<MiniFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String submittedName = '';
  String submittedMessage = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        submittedName = nameController.text;
        submittedMessage = messageController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Full Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Message Field
                  TextFormField(
                    controller: messageController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),

            const SizedBox(height: 20),

            // Preview Area (only show after submit)
            if (submittedName.isNotEmpty && submittedMessage.isNotEmpty)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Name: $submittedName'),
                      const SizedBox(height: 4),
                      Text('Message: $submittedMessage'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}