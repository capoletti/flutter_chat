import 'dart:io';

import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSingup) {
      return _showError('imagem não selecionada');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSingup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_formData.isSingup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (value) => _formData.name = value,
                  decoration: const InputDecoration(labelText: 'nome'),
                  validator: (value) {
                    final name = value ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter pelo menos 5 caracteres.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (value) => _formData.email = value,
                decoration: const InputDecoration(labelText: 'e-mail'),
                validator: (value) {
                  final email = value ?? '';
                  if (!email.contains('@')) {
                    return 'E-mail inválido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                obscureText: true,
                initialValue: _formData.password,
                onChanged: (value) => _formData.password = value,
                decoration: const InputDecoration(labelText: 'senha'),
                validator: (value) {
                  final name = value ?? '';
                  if (name.trim().length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: _formData.isLogin
                    ? const Text('Entrar')
                    : const Text('Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: _formData.isLogin
                    ? const Text('Criar uma nova conta?')
                    : const Text('Já possui conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
