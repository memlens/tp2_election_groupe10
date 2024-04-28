import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'candidates.dart';

class AddElectPage extends StatefulWidget {
  final Function(Candidate) addCandidate;

  const AddElectPage({required this.addCandidate, super.key});

  @override
  _AddElectPageState createState() => _AddElectPageState();
}

class _AddElectPageState extends State<AddElectPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surname = '';
  String _party = '';
  String _bio = '';
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final candidate = Candidate(
        name: _name,
        surname: _surname,
        party: _party,
        bio: _bio,
        image: _image,
      );

      widget.addCandidate(candidate);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Candidate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Candidate image
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? const Icon(Icons.camera_alt) : null,
                  ),
                ),
                // Name
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                // Surname
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Surname'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a surname';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _surname = value!;
                  },
                ),
                // Party
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Party'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a party';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _party = value!;
                  },
                ),
                // Bio
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Biography'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a biography';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _bio = value!;
                  },
                ),
                // Add button
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
