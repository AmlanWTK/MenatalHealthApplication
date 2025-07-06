import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GratitudeWallPage extends StatefulWidget {
  const GratitudeWallPage({Key? key}) : super(key: key);

  @override
  State<GratitudeWallPage> createState() => _GratitudeWallPageState();
}

class _GratitudeWallPageState extends State<GratitudeWallPage> {
  late Future<List<dynamic>> _gratitudeEntries;

  /// Fetches all public gratitude entries from Supabase
  Future<List<dynamic>> fetchGratitudes() async {
    final response = await Supabase.instance.client
        .from('gratitude_entries')
        .select()
        .eq('is_public', true)
        .order('created_at', ascending: false);
    return response;
  }

  @override
  void initState() {
    super.initState();
    _gratitudeEntries = fetchGratitudes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gratitude Wall')),
      body: FutureBuilder<List<dynamic>>(
        future: _gratitudeEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No public gratitude posts yet.'));
          }

          final entries = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://i.imgur.com/U2ZPjYe.jpeg'), // optional
                    fit: BoxFit.cover,
                    opacity: 0.1,
                  ),
                 
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💬 ${entry['text']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (entry['category'] != null)
                          Chip(
                            label: Text(entry['category']),
                            backgroundColor: Colors.orange[100],
                          ),
                        Text(
                          entry['created_at'].toString().substring(0, 10),
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
