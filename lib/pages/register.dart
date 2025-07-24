import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'login.dart';
import '../information/termsAndCond.dart';
import '../database/db_helper.dart';
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool hasDietaryRestrictions = false;
  String selectedDietaryRestriction = '';
  bool agreeToTerms = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

<<<<<<< Updated upstream
<<<<<<< Updated upstream
  void _submitForm() {
    if (_formKey.currentState!.validate() && agreeToTerms) {
      // Handle registration logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registering user...')),
      );
    } else if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions.')),
      );
=======
=======
>>>>>>> Stashed changes
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must agree to the terms and conditions.')),
        );
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match.')),
        );
        return;
      }

      // Check if email or username already exists
      final dbHelper = DatabaseHelper.instance;
      final emailExists = await dbHelper.getUserByEmail(emailController.text);
      final usernameExists = await dbHelper.getUserByUsername(usernameController.text);

      if (emailExists != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email already registered.')),
        );
        return;
      }

      if (usernameExists != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username already taken.')),
        );
        return;
      }

      // Register the user
      final user = {
        'firstName': firstNameController.text,
        'middleInitial': middleInitialController.text,
        'lastName': lastNameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text, // In a real app, you should hash this
        'hasDietaryRestrictions': hasDietaryRestrictions ? 1 : 0,
        'dietaryRestriction': selectedDietaryRestriction,
        'createdAt': DateTime.now().toIso8601String(),
      };

      try {
        await dbHelper.insertUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0df),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'HealthTingi',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(firstNameController, 'First Name'),
                      const SizedBox(height: 8),
                      _buildTextField(firstNameController, 'Middle Initial'),
                      const SizedBox(height: 8),
                      _buildTextField(lastNameController, 'Last Name'),
                      const SizedBox(height: 8),
                      _buildTextField(usernameController, 'Username'),
                      const SizedBox(height: 8),
                      _buildTextField(emailController, 'Email Address'),
                      const SizedBox(height: 12),
                      const Text('Do you have any Dietary Restrictions?'),
                      Row(
                        children: [
                          Checkbox(
                            value: hasDietaryRestrictions,
                            onChanged: (val) => setState(() => hasDietaryRestrictions = val!),
                          ),
                          const Text('Yes'),
                          Checkbox(
                            value: !hasDietaryRestrictions,
                            onChanged: (val) => setState(() => hasDietaryRestrictions = !val!),
                          ),
                          const Text('No'),
                        ],
                      ),
                      if (hasDietaryRestrictions) ...[
                        const Text('Please select which dietary restrictions you have'),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          hint: const Text('Dietary Restrictions'),
                          items: [
                            'Vegan', 'Vegetarian', 'Gluten-Free', 'Lactose Intolerant'
                          ].map((restriction) {
                            return DropdownMenuItem<String>(
                              value: restriction,
                              child: Text(restriction),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => selectedDietaryRestriction = val!),
                        ),
                      ],
                      const SizedBox(height: 12),
                      _buildTextField(passwordController, 'Password', isObscure: true),
                      const SizedBox(height: 8),
                      _buildTextField(confirmPasswordController, 'Confirm Password', isObscure: true),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(
                            value: agreeToTerms,
                            onChanged: (val) => setState(() => agreeToTerms = val!),
                          ),
                          const Flexible(
                            child: Text('I agree to the terms and conditions'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[300],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: const Text('REGISTER'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an Account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // or navigate to login page
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isObscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}
