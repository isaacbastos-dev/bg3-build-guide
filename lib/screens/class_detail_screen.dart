import 'package:flutter/material.dart';

import '../models/bg3_class.dart';

class ClassDetailScreen extends StatelessWidget {
  final Bg3Class classe;

  const ClassDetailScreen({
    super.key,
    required this.classe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classe.nome),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    classe.imagem,
                    width: 110,
                    height: 110,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    classe.nome,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE8D7B0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _InfoCard(
              titulo: 'Distribuição recomendada',
              conteudo: classe.atributos,
            ),

            const SizedBox(height: 16),

            _InfoCard(
              titulo: 'Subclasse recomendada',
              conteudo: classe.subclasseRecomendada,
            ),

            const SizedBox(height: 16),

            _InfoCard(
              titulo: 'Por que escolher?',
              conteudo: classe.motivo,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String titulo;
  final String conteudo;

  const _InfoCard({
    required this.titulo,
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1915),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3024),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC6A15B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            conteudo,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Color(0xFFE8D7B0),
            ),
          ),
        ],
      ),
    );
  }
}