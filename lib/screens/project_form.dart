import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";

  // Project URL opsional, tetapi formatnya harus valid jika diisi.
  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(value.trim());

    if (uri == null ||
        !uri.hasScheme ||
        !uri.hasAuthority ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return "Masukkan URL yang valid!";
    }

    return null;
  }

  // Mengirim proyek ke backend.
  Future<void> _submit() async {
    // 1. Validasi form.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Pastikan pengguna sudah login.
    final loggedIn = await ensureLoggedIn(context);

    if (!loggedIn || !mounted) {
      return;
    }

    final authState = context.read<AuthState>();
    final token = authState.token;

    if (token == null) {
      return;
    }

    // 3. Membuat objek Project.
    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      // 4. Mengirim proyek ke backend.
      final createdProject = await context.read<ApiClient>().createProject(
        newProject,
        token: token,
      );

      if (!mounted) return;

      // 5. Menampilkan konfirmasi jika berhasil.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text(
              'Proyek berhasil ditambahkan!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${createdProject.title}'),
                  Text('Description: ${createdProject.description}'),
                  Text('Tech Stack: ${createdProject.techStack}'),
                  Text('Project URL: ${createdProject.projectUrl}'),
                  Text('Project Image URL: ${createdProject.projectImageUrl}'),
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

                  setState(() {
                    _title = "";
                    _description = "";
                    _techStack = "";
                    _projectUrl = "";
                    _projectImageUrl = "";
                  });
                },
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;

      // 6. Jika token tidak valid (401).
      if (e.statusCode == 401) {
        await authState.logout();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi login berakhir. Silakan login kembali.'),
          ),
        );

        await ensureLoggedIn(context);
      } else {
        // Error selain 401.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan proyek: ${e.message}')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
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
              // === Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Proyek",
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _title = value ?? "";
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama Proyek tidak boleh kosong!";
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
                    hintText: "Deskripsi Proyek",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _description = value ?? "";
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tech Stack ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, Figma",
                    labelText: "Tech Stack",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _techStack = value ?? "";
                  },
                ),
              ),

              // === Project URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Proyek (opsional)",
                    labelText: "Project URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _projectUrl = value ?? "";
                  },
                  validator: _validateUrl,
                ),
              ),

              // === Project Image URL (Optional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Gambar Proyek (opsional)",
                    labelText: "Project Image URL (Optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    _projectImageUrl = value ?? "";
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
                    onPressed: _submit,
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
