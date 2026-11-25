import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _eduTitle = "";
  String _description = "";
  String _category = "Formal Education"; // default
  String _eduLink = "";
  String _duration = ""; // default

  final List<String> _categories = [
    'Formal Education',
    'Educational Program',
    'Certification',
    'Course / Training',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
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
              // === Education Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Pendidikan",
                    labelText: "Nama Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _eduTitle = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama pendidikan tidak boleh kosong!";
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
                    hintText: "Deskripsi Pendidikan",
                    labelText: "Deskripsi Pendidikan (opsional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pendidikan",
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

              // === Education Link ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Pendidikan (opsional)",
                    labelText: "Tautan Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _eduLink = value!;
                    });
                  },
                ),
              ),

              // === Duration ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "2021 - 2025",
                    labelText: "Durasi Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _duration = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Durasi pendidikan tidak boleh kosong!";
                    }
                    return null;
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
                                'Pendidikan berhasil ditambahkan!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama Institusi Pendidikan: $_eduTitle',
                                    ),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: $_category'),
                                    Text('Durasi: $_duration'),
                                    Text('Tautan: $_eduLink'),
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
