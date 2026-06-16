import 'package:flutter/material.dart';
import 'gallery_widget.dart';
import 'models.dart';
import 'edit_profile_page.dart';
import 'edit_experience_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 1;

  ProfileInfo profile = ProfileInfo(
    name: 'ELDY FIRMANSYAH',
    role: 'Mahasiswa Teknik Informatika',
    imageUrl: 'https://www.instagram.com/eldyfirmansyahg?igsh=cDR4YmZ5cnQ5d3Zm',
    about: 'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.',
    education: 'Universitas Pasundan — Semester 6\nIPK: 3.17',
    location: 'Bandung, Indonesia',
    contact: 'email@example.com\n+62 857-2261-0509',
    skills: ['Flutter', 'Dart', 'UI Design', 'Firebase', 'Git'],
  );

  ExperienceInfo experience = ExperienceInfo(
    title: 'Mobile Developer Intern',
    description: 'Bekerja pada pengembangan aplikasi mobile menggunakan Flutter di sebuah startup teknologi.',
    imageUrl: 'https://via.placeholder.com/150',
  );

  @override
  Widget build(BuildContext context) {
    // Daftar halaman untuk setiap tab
    Widget body;
    switch (_selectedIndex) {
      case 0:
        body = const Center(child: Text('Halaman Home', style: TextStyle(fontSize: 24)));
        break;
      case 1:
        body = _buildProfileContent();
        break;
      case 2:
        body = const Center(child: Text('Halaman Pesan', style: TextStyle(fontSize: 24)));
        break;
      case 3:
        body = const Center(child: Text('Halaman Pengaturan', style: TextStyle(fontSize: 24)));
        break;
      default:
        body = _buildProfileContent();
    }

    // Judul AppBar berubah sesuai tab
    final List<String> titles = ['Home', 'Profil Saya', 'Pesan', 'Pengaturan'];
    final String currentTitle = _selectedIndex < titles.length ? titles[_selectedIndex] : 'Profil Saya';

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Edit Pengalaman'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditExperiencePage(experience: experience),
                  ),
                );
                if (result != null && result is ExperienceInfo) {
                  setState(() {
                    experience = result;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 3);
              },
            ),
          ],
        ),
      ),
      body: body,
      floatingActionButton: _selectedIndex == 1 ? Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(profile: profile),
              ),
            );
            if (result != null && result is ProfileInfo) {
              setState(() {
                profile = result;
              });
            }
          },
          child: const Icon(Icons.edit),
        );
      }) : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onDestinationSelected: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // === HEADER PROFIL ===
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profile.imageUrl),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.role,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // === BARIS STATISTIK (Row + Expanded) ===
          Row(
            children: [
              Expanded(child: _StatBox(label: 'Post', value: '1')),
              Expanded(child: _StatBox(label: 'Teman', value: '20')),
              Expanded(child: _StatBox(label: 'Like', value: '1.2M')),
            ],
          ),
          const SizedBox(height: 24),
          // === SECTION CARD ===
          _SectionCard(
            icon: Icons.info_outline,
            title: 'Tentang Saya',
            content: profile.about,
          ),
          _SectionCard(
            icon: Icons.school,
            title: 'Pendidikan',
            content: profile.education,
          ),
          _SectionCard(
            icon: Icons.location_on,
            title: 'Lokasi',
            content: profile.location,
          ),
          _SectionCard(
            icon: Icons.email,
            title: 'Kontak',
            content: profile.contact,
          ),
          // === TUGAS MANDIRI 3: SKILLS ===
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.blue),
                      SizedBox(width: 16),
                      Text('Skills',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: profile.skills.map((skill) => Chip(label: Text(skill))).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // === BONUS: EXPERIENCE SECTION ===
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.work, color: Colors.blue),
                      SizedBox(width: 16),
                      Text('Pengalaman',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        experience.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => const Icon(Icons.image, size: 60),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(experience.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(experience.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80), // ruang agar FAB tidak nutupi konten
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _SectionCard(
      {required this.icon, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
