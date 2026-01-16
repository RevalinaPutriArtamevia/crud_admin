import 'package:flutter/material.dart';
import '../styles/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  String error = "";

  void login() {
    final u = userCtrl.text.trim();
    final p = passCtrl.text.trim();

    if (u == "admin" && p == "123") {
      Navigator.pushReplacementNamed(context, "/dashboard");
      return;
    }

    setState(() {
      error = "Username atau password salah";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,

      body: Center(
        child: Container(
          width: 420,

          // 👉 PADDING LOGIN
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
              )
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Icon(
                Icons.lock,
                size: 60,
                color: AppTheme.primary,
              ),

              const SizedBox(height: 12),

              const Text(
                "LOGIN ADMIN",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: userCtrl,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              if (error.isNotEmpty)
                Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text("Masuk"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
