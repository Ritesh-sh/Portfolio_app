import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  // Sample data
  final Map<String, String> education = {
    '10th': 'St. Francis DeSales  High School, 2018 - 87.20%',
    '12th': 'St. Francis DeSales College, 2020 - 75.23%',
    'Graduation':
        'Rashtrasant Tukadoji Maharaj Nagpur University, B.Sc-Mathematics, 2022 - 79.62%',
  };

  final List<String> skills = [
    'P/LSQL',
    'Mysql',
    'Python',
    'Java',
    'C++',
    'Maths',
    'OOPs',
    'Data Structure',
  ];

  final List<Map<String, String>> projects = [
    {
      'title': 'E-Commerce App',
      'description':
          'Built a full-stack e-commerce app using Flutter and Firebase.',
    },
    {
      'title': 'Weather App',
      'description':
          'A weather app that fetches real-time data using OpenWeatherMap API.',
    },
    {
      'title': 'Portfolio Website',
      'description':
          'Created a responsive portfolio website using HTML, CSS, and JavaScript.',
    },
  ];

  final Map<String, String> contact = {
    'Email': 'mailto:sharmaji9579@gmail.com',
    'Phone': 'tel:+917219274799',
    'LinkedIn':
        'https://www.linkedin.com/in/ritesh-sharma-451279295?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
    'Instagram': 'https://www.instagram.com/_sharma_ji__24',
  };

  // Function to launch URLs
  Future<void> _launchURL(String url) async {
    // Convert the URL string to a Uri object
    final Uri uri = Uri.parse(url);

    // Check if the URL can be launched
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Photo
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/profile.jpg'), // Add your image in assets
            ),
            SizedBox(height: 16.0),
            Text(
              'Ritesh Sharma',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            // Introduction Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Hello! I am a passionate Software developer with expertise in core Java (OOP, algorithms) and a strong math foundation. Focused on crafting efficient, scalable solutions through analytical problem-solving and technical precision. '
                'I love solving problems and creating Something new.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 24.0),

            // Education Section
            _buildSectionTitle('Education'),
            ...education.entries.map((entry) {
              return _buildListItem(entry.key, entry.value);
            }),

            // Skills Section
            _buildSectionTitle('Skills'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Colors.blue[50],
                );
              }).toList(),
            ),

            // Projects Section
            _buildSectionTitle('Projects'),
            ...projects.map((project) {
              return _buildProjectCard(
                  project['title']!, project['description']!);
            }),

            // Contact Section
            _buildSectionTitle('Contact'),
            ...contact.entries.map((entry) {
              return _buildContactItem(entry.key, entry.value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildProjectCard(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(description),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(String title, String url) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        url.replaceFirst(RegExp(r'^mailto:|tel:|https?://'), ''),
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () => _launchURL(url),
    );
  }
}
