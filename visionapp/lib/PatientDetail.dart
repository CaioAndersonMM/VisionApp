import 'package:flutter/material.dart';
import 'package:visionapp/main.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientName;
  final int age;
  final String dataconsulta;

  // Variáveis para diagnóstico e receitas
  String diagnosis =
      'O paciente tem miopia e astigmatismo.\n- A imagem apresentou um problema X';
  String prescriptions =
      '- Prescrição de óculos com grau: -2.00 e -1.50.\n- Recomenda-se acompanhamento anual.\n- Uso de colírios hidratantes diariamente.';

  PatientDetailsPage({
    Key? key,
    required this.patientName,
    required this.age,
    required this.dataconsulta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Paciente'),
        backgroundColor: const Color.fromARGB(255, 1, 29, 58), // Azul
        elevation: 10, // Sombra da AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 5, 39, 75), // Azul
              Color.fromARGB(255, 96, 88, 180), // Branco
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Linha para o nome do paciente e a foto
                    Row(
                      children: [
                        // Imagem do paciente
                        ClipOval(
                          child: Image.network(
                            'https://picsum.photos/90', // Imagem aleatória
                            width: 80, // Largura da imagem
                            height: 80, // Altura da imagem
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Espaçamento entre a imagem e o texto
                        Text(
                          "$patientName, $age",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Fotos tiradas: 5',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Data da consulta: $dataconsulta',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'Imagens do Olho',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Coluna de imagens
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildImageContainer(
                            'https://picsum.photos/100?random=1',
                            context,
                          ),
                          const SizedBox(width: 10),
                          _buildImageContainer(
                            'https://picsum.photos/100?random=2',
                            context,
                          ),
                          const SizedBox(width: 10),
                          _buildImageContainer(
                            'https://picsum.photos/100?random=3',
                            context,
                          ),
                          const SizedBox(width: 10),
                          _buildImageContainer(
                            'https://picsum.photos/100?random=4',
                            context,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Título para Diagnóstico
                    _buildTitleWithEditIcon(
                      title: 'Diagnóstico',
                      onEdit: () {
                        _showEditDialog(context, 'Diagnóstico', diagnosis,
                            (newValue) {
                          diagnosis = newValue; // Atualiza o diagnóstico
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildInfoCard(
                      content: diagnosis,
                      onEdit: () {
                        _showEditDialog(context, 'Diagnóstico', diagnosis,
                            (newValue) {
                          diagnosis = newValue; // Atualiza o diagnóstico
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    // Título para Receitas
                    _buildTitleWithEditIcon(
                      title: 'Receitas',
                      onEdit: () {
                        _showEditDialog(context, 'Receitas', prescriptions,
                            (newValue) {
                          prescriptions = newValue; // Atualiza as receitas
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildInfoCard(
                      content: prescriptions,
                      onEdit: () {
                        _showEditDialog(context, 'Receitas', prescriptions,
                            (newValue) {
                          prescriptions = newValue; // Atualiza as receitas
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Contatos",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 255, 255, 255)),
                    ),
                    // Row para os CustomCards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomCard(
                            color1:
                                const Color.fromARGB(255, 5, 20, 36), // Azul
                            color2:
                                const Color.fromARGB(255, 1, 81, 161), // Azul
                            title: 'Chat com Paciente',
                            onTap: () {
                              // Ação para Contato
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            color1:
                                const Color.fromARGB(255, 5, 20, 36), // Azul
                            color2:
                                const Color.fromARGB(255, 1, 81, 161), // Azul
                            title: 'Enviar outro Especialista',
                            onTap: () {
                              // Ação para Contato
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCard(
                            color1: const Color.fromARGB(255, 0, 0, 0), // Azul
                            color2: const Color.fromARGB(255, 17, 4, 2), // Azul
                            title: 'Baixar PDF',
                            onTap: () {
                              // Ação para Contato
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Diálogo para editar diagnóstico e receitas
  void _showEditDialog(BuildContext context, String title, String initialValue,
      Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Bordas arredondadas
          ),
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // 80% da largura da tela
            padding: const EdgeInsets.all(16.0), // Padding interno
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ocupar espaço mínimo necessário
              children: [
                Text(
                  'Editar $title',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 20), // Espaçamento entre o título e o campo
                TextField(
                  controller: controller,
                  maxLines: 5, // Permite mais linhas
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Insira o novo valor',
                  ),
                ),
                const SizedBox(
                    height: 20), // Espaçamento entre o campo e os botões
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        onSave(controller.text);
                        Navigator.of(context).pop(); // Fecha o diálogo
                      },
                      child: const Text('Salvar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Fecha o diálogo sem salvar
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(
      {required String content, required VoidCallback onEdit}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10, // Sombra mais suave
            offset: Offset(0, 4), // Offset da sombra
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imageUrl, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFullScreenImage(imageUrl, context);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 2), // Borda branca
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(String imageUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Fecha o diálogo ao tocar na imagem
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleWithEditIcon(
      {required String title, required VoidCallback onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(221, 255, 255, 255)),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onEdit, // Chama onEdit ao tocar no texto
          child: const Text(
            'Editar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: onEdit,
        ),
      ],
    );
  }
}
