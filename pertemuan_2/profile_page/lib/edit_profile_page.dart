import 'package:flutter/material.dart';
import 'models.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileInfo profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _imageController;
  late TextEditingController _aboutController;
  late TextEditingController _educationController;
  late TextEditingController _locationController;
  late TextEditingController _contactController;
  late TextEditingController _skillsController;

  final Color primaryColor = const Color(0xFF5A5A8F);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _roleController = TextEditingController(text: widget.profile.role);
    _imageController = TextEditingController(text: widget.profile.imageUrl);
    _aboutController = TextEditingController(text: widget.profile.about);
    _educationController = TextEditingController(text: widget.profile.education);
    _locationController = TextEditingController(text: widget.profile.location);
    _contactController = TextEditingController(text: widget.profile.contact);
    _skillsController = TextEditingController(text: widget.profile.skills.join(', '));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _imageController.dispose();
    _aboutController.dispose();
    _educationController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final updatedProfile = ProfileInfo(
      name: _nameController.text,
      role: _roleController.text,
      imageUrl: _imageController.text,
      about: _aboutController.text,
      education: _educationController.text,
      location: _locationController.text,
      contact: _contactController.text,
      skills: _skillsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
    Navigator.pop(context, updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Profil', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Row(
              children: [
                Icon(Icons.check, size: 18, color: primaryColor),
                const SizedBox(width: 4),
                Text('Simpan', style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Photo Section
            Center(
              child: Column(
                children: [
                  Text('Foto Profil',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: NetworkImage(_imageController.text),
                        onBackgroundImageError: (_, __) {},
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // Logic for showing URL field or picker
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image_outlined, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text('Ganti Foto dari Galeri',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text('Informasi Profil',
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Nama Lengkap *',
              controller: _nameController,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Pekerjaan / Role',
              controller: _roleController,
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Bio / Tentang',
              controller: _aboutController,
              icon: Icons.info_outline,
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'URL Foto Profil',
              controller: _imageController,
              icon: Icons.link,
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Pendidikan',
              controller: _educationController,
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Lokasi',
              controller: _locationController,
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Kontak',
              controller: _contactController,
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Skills (pisahkan dengan koma)',
              controller: _skillsController,
              icon: Icons.star_outline,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                icon: const Icon(Icons.save),
                label: const Text('Simpan Perubahan'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.grey.shade600),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
