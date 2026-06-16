import 'package:flutter/material.dart';
import 'models.dart';

class EditExperiencePage extends StatefulWidget {
  final ExperienceInfo experience;

  const EditExperiencePage({super.key, required this.experience});

  @override
  State<EditExperiencePage> createState() => _EditExperiencePageState();
}

class _EditExperiencePageState extends State<EditExperiencePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  final Color primaryColor = const Color(0xFF5A5A8F);

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.experience.title);
    _descriptionController = TextEditingController(text: widget.experience.description);
    _imageController = TextEditingController(text: widget.experience.imageUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveExperience() {
    final updatedExperience = ExperienceInfo(
      title: _titleController.text,
      description: _descriptionController.text,
      imageUrl: _imageController.text,
    );
    Navigator.pop(context, updatedExperience);
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
        title: const Text('Upload Pengalaman', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: _saveExperience,
            child: Row(
              children: [
                Icon(Icons.save_outlined, size: 18, color: primaryColor),
                const SizedBox(width: 4),
                Text('Simpan', style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Upload Placeholder
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 48, color: primaryColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  Text('Ketuk untuk pilih gambar',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                  Text('dari galeri perangkat kamu',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Informasi Pengalaman',
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Judul *',
              controller: _titleController,
              icon: Icons.title,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Deskripsi',
              controller: _descriptionController,
              icon: Icons.description_outlined,
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'URL Gambar (untuk sementara)',
              controller: _imageController,
              icon: Icons.link,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _saveExperience,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                icon: const Icon(Icons.save),
                label: const Text('Simpan Pengalaman'),
              ),
            ),
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
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
