import 'package:duobr_project/presentation/widgets/custom_appbar.dart';
import 'package:duobr_project/presentation/widgets/custom_button.dart';
import 'package:duobr_project/presentation/widgets/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:duobr_project/core/di/injector.dart';
import 'package:duobr_project/core/routes/app_routes.dart';
import 'package:duobr_project/presentation/stores/auth_store.dart';

class RegisterPage extends StatelessWidget {
  final AuthStore _authStore = getIt<AuthStore>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro",
        showThemeSwitcher: true,
        prefixIcon: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login)),
      ),
      body: Observer(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de e-mail
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "E-mail", border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Campo de senha
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Senha", border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                // Mensagem de erro
                if (_authStore.errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
                        const SizedBox(width: 8),
                        Expanded(child: Text(_authStore.errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error))),
                      ],
                    ),
                  ),
                if (_authStore.errorMessage != null) const SizedBox(height: 16),

                CustomButton(
                  text: "Cadastrar",
                  isLoading: _authStore.isLoading,
                  onPressed: _authStore.isLoading ? null : () => _register(context),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).textTheme.labelMedium?.color,
                ),
                const SizedBox(height: 16),

                // Link para login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Já tem uma conta?"),
                    TextButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login), child: const Text("Faça login")),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preencha todos os campos."), backgroundColor: Colors.red));
      return;
    }
    if (_authStore.errorMessage != null) {
      showFlushBar(context: context, message: _authStore.errorMessage!);
      return;
    }
    await _authStore.registerWithEmail(_emailController.text, _passwordController.text);

    if (_authStore.user != null && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cadastro realizado com sucesso!"), backgroundColor: Colors.green));
    }
  }
}
