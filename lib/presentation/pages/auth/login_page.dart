import 'package:duobr_project/core/routes/app_routes.dart';
import 'package:duobr_project/presentation/widgets/custom_appbar.dart';
import 'package:duobr_project/presentation/widgets/custom_button.dart';
import 'package:duobr_project/presentation/widgets/custom_flushbar.dart';
import 'package:duobr_project/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/presentation/stores/auth_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authStore = getIt<AuthStore>();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  bool _isFormTouched = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (!_isFormTouched) return null;
    if (value == null || value.isEmpty) return 'E-mail é obrigatório';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (!_isFormTouched) return null;
    if (value == null || value.isEmpty) return 'Senha é obrigatória';
    if (value.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    return null;
  }

  Future<void> _login() async {
    setState(() => _isFormTouched = true);

    if (_formKey.currentState?.validate() ?? false) {
      await _authStore.signInWithEmail(_emailController.text, _passwordController.text);

      if (_authStore.user != null && mounted) {
        showFlushBar(context: context, message: 'Login bem-sucedido!', icon: Icons.check_circle);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } else {
      if (_authStore.errorMessage != null && mounted) {
        showFlushBar(context: context, message: _authStore.errorMessage!, icon: Icons.error_outline);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Login", showThemeSwitcher: false),
      body: Observer(
        builder: (_) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Header
                  const SizedBox(height: 40),
                  Icon(Icons.gamepad, size: 100, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 24),
                  Text("Bem-vindo ao DuoBR", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    "Encontre seu duo perfeito",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha((0.7 * 255).toInt())),
                  ),
                  const SizedBox(height: 32),

                  CustomTextField(
                    controller: _emailController,
                    label: "E-mail",
                    prefixIcon: Icons.email,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => setState(() => _isFormTouched = true),
                  ),
                  const SizedBox(height: 16),

                  // Campo de senha
                  CustomTextField(
                    controller: _passwordController,
                    label: "Senha",
                    prefixIcon: Icons.lock,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: _validatePassword,
                    onChanged: (value) => setState(() => _isFormTouched = true),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 16),
                  if (_authStore.errorMessage != null) const SizedBox(height: 16),

                  // Botão de login
                  CustomButton(
                    text: _authStore.isLoading ? "" : "Entrar",
                    isLoading: _authStore.isLoading,
                    onPressed: _authStore.isLoading ? null : () => _login(),
                    textColor: Theme.of(context).textTheme.labelMedium?.color,
                  ),
                  const SizedBox(height: 24),

                  // Divisor
                  Row(
                    children: [
                      Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("OU", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()))),
                      ),
                      Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Login com Google
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      side: BorderSide(color: Theme.of(context).colorScheme.outline),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _authStore.isLoading ? null : () => _authStore.signInWithGoogle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google_logo.png', width: 24, height: 24),
                        const SizedBox(width: 8),
                        const Text("Entrar com Google"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não tem uma conta? ", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha((0.7 * 255).toInt()))),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.register),
                        child: Text("Cadastre-se", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
