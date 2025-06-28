import 'package:flutter/material.dart';
import 'package:mental_health_ai/chatscreen/chatscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? fullName;
  int? age;
  String? gender;
  bool _isLoading = true;
  bool _errorLoadingProfile = false;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) {
        if (mounted) {
          setState(() {
            _errorLoadingProfile = true;
            _isLoading = false;
          });
        }
        return;
      }

      final response = await supabase
          .from('profiles')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      if (response != null && mounted) {
        setState(() {
          fullName = response['full_name'];
          age = response['age'];
          gender = response['gender'];
          _isLoading = false;
        });
      } else if (mounted) {
        setState(() {
          _errorLoadingProfile = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorLoadingProfile = true;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading profile:$e")),
        )
        ;
        

      }
    }
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Profile Info"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${fullName ?? "Not available"}"),
              const SizedBox(height: 8),
              Text("Age: ${age?.toString() ?? "Not available"}"),
              const SizedBox(height: 8),
              Text("Gender: ${gender ?? "Not available"}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
            if (_errorLoadingProfile)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _retryProfileLoad();
                },
                child: const Text("Retry"),
              ),
          ],
        );
      },
    );
  }

  Future<void> _retryProfileLoad() async {
    setState(() {
      _isLoading = true;
      _errorLoadingProfile = false;
    });
    await _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(
            onPressed: _showProfileDialog,
            icon: const Icon(Icons.account_circle, size: 30),
            tooltip: 'View Profile',
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome ${fullName ?? 'User'}!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
            }, 
            child: Text("Open chat")
            )
            ,

            if (_errorLoadingProfile) ...[
              const SizedBox(height: 20),
              const Text(
                "Couldn't load profile details",
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _retryProfileLoad,
                child: const Text("Try Again"),
              ),
            ],


          ],
        ),
      ),
    );
  }
}