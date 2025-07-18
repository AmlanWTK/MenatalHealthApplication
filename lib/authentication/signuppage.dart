import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    final supabase = Supabase.instance.client;
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final fullName = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    final gender = _genderController.text.trim();

    setState(() => _isLoading = true);

    try {
      // 1. Sign up the user
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      // 2. Get the user from the response
      final user = response.user;
      if (user == null) throw Exception('User not found after signup');

      // 3. Create profile
      await supabase.from('profiles').insert({
        'user_id': user.id,
        'full_name': fullName,
        'age': age,
        'gender': gender,
      });

      // 4. Navigate to homepage
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Homepage()),
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during signup: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: GoogleFonts.playfairDisplay(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: 600,
        width: double.infinity,

        padding: const EdgeInsets.all(24.0),
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.cyan.shade100,width: 3),
          boxShadow: [
  BoxShadow(
    color: Colors.cyanAccent.withOpacity(0.3),
    offset: Offset(3, 3),
    blurRadius: 5,
    spreadRadius: 1
  ),
 BoxShadow(
    color: Colors.white.withOpacity(0.8), // highlight side
    offset: Offset(-3, -3),
    blurRadius: 5,
    spreadRadius: 1,
  ),
  
]
          
        ),
        child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
              )
                      ],
                    ),
                    clipBehavior: Clip.antiAlias, // Clip rounded corners
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Lottie.asset(
              'assets/animations/welcome2.json',
              fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
                 
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Email Field
                  Container(
                   constraints: BoxConstraints(maxWidth: 500),
                   
                    child: TextFormField(
                      
                      controller: _emailController,
                      decoration:  InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.dancingScript(fontSize: 22,color: Colors.blueGrey,fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
              
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blueGrey, width: 3)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue)
                        )
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!EmailValidator.validate(value.trim())) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password Field
                  Container(
                     constraints: BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                         labelStyle: GoogleFonts.dancingScript(fontSize: 22,color: Colors.blueGrey,fontWeight: FontWeight.bold),
                        labelText: "Password",
                        prefixIcon:  Icon(Icons.lock),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          
                          
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blueGrey, width: 3)
                          
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Full Name Field
                  Container(  
                    constraints: BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _nameController,
                      decoration:  InputDecoration(
                         labelStyle: GoogleFonts.dancingScript(fontSize: 22,color: Colors.blueGrey,fontWeight: FontWeight.bold),
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blueGrey,width: 3)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                         borderSide: BorderSide(color: Colors.blue)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Age Field
                  Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    
              
                    child: TextFormField(
                      controller: _ageController,
                      decoration:  InputDecoration(
                         labelStyle: GoogleFonts.dancingScript(fontSize: 22,color: Colors.blueGrey,fontWeight: FontWeight.bold),
                        labelText: "Age",
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blueGrey,width: 3)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue)
                        )
                      ),
                      
                      
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        final age = int.tryParse(value);
                        if (age == null || age < 13 || age > 120) {
                          return 'Please enter a valid age (13-120)';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Gender Field
                  Container(
                     constraints: BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      controller: _genderController,
                      decoration:InputDecoration(
                         labelStyle: GoogleFonts.dancingScript(fontSize: 22,color: Colors.blueGrey,fontWeight: FontWeight.bold),
                        labelText: "Gender",
                        prefixIcon: Icon(Icons.transgender),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blueGrey,width: 3)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Sign Up Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signup,
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      elevation: 6,
                      shadowColor: Colors.blueGrey.withOpacity(0.4),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.blueGrey,
                              strokeWidth: 2,
                            ),
                          )
                        :  Text(
                            "Sign Up",
                            style: GoogleFonts.playfairDisplay(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1.2),
                          ),
                  ),
                  const SizedBox(height: 16),
                  // Login Link
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child:
                    //  SizedBox(
                    //   height: 40,
                    //   child: DefaultTextStyle(
                    //     style: GoogleFonts.playfairDisplay(fontSize:30,fontWeight: FontWeight.bold,color: Color(0xFF7B4B42) ), 
                    //     child: AnimatedTextKit(
                    //       isRepeatingAnimation: false,
                    //       animatedTexts: [
                    //       TypewriterAnimatedText(
                    //                     'Already have an account? Login',
                    //                     speed: Duration(milliseconds: 100),
                    //                     cursor: '|'
                    //                   ) 
                    //     ])
                    //     ),
                    // )
                    
                 Text("Already have an account? Login",style: GoogleFonts.playfairDisplay(fontSize: 30,fontWeight: FontWeight.bold,color: const Color(0xFF7B4B42),), ),
                    
                   
                  ),
                ],
              ),
            ),
          ),

            ],
          )


       


        ),
      ),
    );
  }
}