import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLogin;
  const RegisterPage({Key? key, required this.showLogin}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': emailController.text.split('@')[0],
          'bio':'Empty bio....'
        });


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => YourNextScreen()),
        );
      } catch (e) {
        print("Error registering user: $e");
 
      }
    }
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/w2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //App Name
                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                //welcome message
                const Text(
                  'Register here using your details!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 50),
                //email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter your Email',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Enter your Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //Confirm password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Confirm your Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //member or not
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.showLogin,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
     ));
  }
}

class YourNextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('This is your next screen.'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterPage(
      showLogin: () {},
    ),
  ));
}
