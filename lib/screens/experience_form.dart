import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _experienceTitle = "";
  String _description = "";
  String _category = "Committee"; // default
  String _experienceLink = "";
  String _status = "On Going"; // default

  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
    'Committee',
  ];

  final List<String> _statuses = ['On Going', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),

      drawer: const LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Experience Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Pengalaman",
                    labelText: "Nama Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _experienceTitle = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Pengalaman",
                    labelText: "Deskripsi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Experience Link ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Pengalaman (opsional)",
                    labelText: "Tautan Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _experienceLink = value!;
                    });
                  },
                ),
              ),

              // === Status ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Status Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _status,
                  items: _statuses
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _status = newValue!;
                    });
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              title: const Text(
                                'Pengalaman berhasil ditambahkan!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Pengalaman: $_experienceTitle'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: $_category'),
                                    Text('Status: $_status'),
                                    Text('Tautan: $_experienceLink'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
