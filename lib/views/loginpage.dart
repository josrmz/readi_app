import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readi_app/shared/utils.dart';
import 'package:go_router/go_router.dart';
import '../widgets/textfield_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      context.push("/homepage");

    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(
        context: context, 
        title: e.message ?? "Error al iniciar sesión",
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
/*
  Future<UserCredential?> _handleGoogleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                const Text(
                  'Bienvenido de nuevo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Inicia sesión en tu cuenta',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),

                const SizedBox(height: 32),

                CustomTextField(
                  label: 'Correo electronico',
                  hint: 'ejemplo@correo.com',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Ingresa tu correo';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Contraseña',
                  hint: '••••••••',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixIconTap: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }
                    if(value.length < 6) {
                      return 'Debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF875AA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () async {
                      //final user = await _handleGoogleSignIn();

                      //if(user != null && mounted){
                        context.push("/homepage");
                      //}
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png', height: 24),
                        const SizedBox(width: 10),
                        const Text("Continuar con Google"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: TextButton(
                    onPressed: () {
                      context.push('/signup');
                    },
                    child: const Text("Crear cuenta"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
