import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
//Fonction pour l'envoie des données
  Future<bool> sendJSONData(String url, Map<String, dynamic> data) async {
    // Convertir les données en JSON
    final jsonData = jsonEncode(data);

    // Envoyer la requête HTTP POST avec les données JSON
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    // Vérifier le code de statut de la réponse
    print("response status : ");
    print(response.statusCode);
    return (response.statusCode >= 200 && response.statusCode <= 299);
  }
// Fin de la fonction
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final candidate = Candidate(
        name: _name,
        surname: _surname,
        party: _party,
        bio: _bio,
        imageUrl: _image,
      );

      final data = {
        "userId": 1,
        // Remplacez par l'ID de l'utilisateur approprié
        "id": 0,
        // L'ID sera attribué par le serveur
        "title": "$_name $_surname",
        // Utilisez les champs name et surname pour le titre
        "body": "$_party $_bio",
        // Utilisez les champs party et bio pour le corps
      };
//Test de la fonction http
      final success = await sendJSONData('https://jsonplaceholder.typicode.com/posts', data);
      if (success) {
        print('Données envoyées avec succès');
        widget.addCandidate(candidate);
        Navigator.pop(context);
      } else {
        print('Erreur lors de l\'envoi des données');
      }
// fin du test
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Candidate'),
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
                //ajout d'un margin au boutton
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
