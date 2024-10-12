import 'package:flutter/material.dart';
import 'package:visionapp/ChatPage.dart';
import 'package:visionapp/main.dart';

class PatientDetailsPage extends StatefulWidget {
  final String patientName;
  final int age;
  final String dataconsulta;

  const PatientDetailsPage({
    super.key,
    required this.patientName,
    required this.age,
    required this.dataconsulta,
  });

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  String diagnosis =
      'O paciente tem miopia e astigmatismo.\n- A imagem apresentou um problema X';
  String prescriptions =
      '- Prescrição de óculos com grau: -2.00 e -1.50.\n- Recomenda-se acompanhamento anual.\n- Uso de colírios hidratantes diariamente.';

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Paciente'),
        backgroundColor: const Color.fromARGB(255, 1, 9, 19),
        elevation: 10,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 5, 39, 75),
              Color.fromARGB(255, 96, 88, 180),
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
                    _buildPatientInfo(),
                    const SizedBox(height: 30),
                    _buildDocumentsSection(),
                    const SizedBox(height: 20),
                    _buildImagesSection(),
                    const SizedBox(height: 20),
                    _buildDiagnosisSection(),
                    const SizedBox(height: 10),
                    _buildPrescriptionsSection(),
                    const SizedBox(height: 20),
                    _buildOptionsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widgets componentização

  Widget _buildPatientInfo() {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            'https://picsum.photos/90',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.patientName}, ${widget.age} anos",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Data da consulta: ${widget.dataconsulta}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(isExpanded ? 'Documentos' : 'Documentos Médicos',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            isExpanded ?
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação para anexar documento
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 81, 161),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0), // Padding interno
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Anexar Documento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.add_to_drive_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ) : const SizedBox(height: 0),
            IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ],
        ),
        
        isExpanded ? const SizedBox(height: 10) : const SizedBox(height: 0),

        SizedBox(
          height: isExpanded ? 60 : 0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildImageContainer(
                  'https://picsum.photos/100?random=13', context),
              const SizedBox(width: 10),
              _buildImageContainer(
                  'https://picsum.photos/100?random=27', context),
              const SizedBox(width: 10),
              _buildImageContainer(
                  'https://picsum.photos/100?random=39', context),
              const SizedBox(width: 10),
              _buildImageContainer(
                  'https://picsum.photos/100?random=42', context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Imagens do Olho',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildImageContainer(
                  'https://picsum.photos/100?random=1', context),
              const SizedBox(width: 10),
              _buildImageContainer(
                  'https://picsum.photos/100?random=2', context),
              const SizedBox(width: 10),
              _buildImageContainer(
                  'https://picsum.photos/100?random=3', context),
              const SizedBox(width: 10),
              _buildImageContainer(
                  'https://picsum.photos/100?random=4', context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiagnosisSection() {
    return _buildInfoSection(
      title: 'Diagnóstico',
      content: diagnosis,
      onEdit: () {
        _showEditDialog(context, 'Diagnóstico', diagnosis, (newValue) {
          setState(() {
            diagnosis = newValue;
          });
        });
      },
    );
  }

  Widget _buildPrescriptionsSection() {
    return _buildInfoSection(
      title: 'Receitas',
      content: prescriptions,
      onEdit: () {
        _showEditDialog(context, 'Receitas', prescriptions, (newValue) {
          setState(() {
            prescriptions = newValue;
          });
        });
      },
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    required VoidCallback onEdit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: onEdit,
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Opções",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(221, 255, 255, 255)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomCard(
                color1: const Color.fromARGB(255, 5, 20, 36),
                color2: const Color.fromARGB(255, 1, 81, 161),
                title: 'Chat com Paciente',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatDetailScreen(widget.patientName),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: CustomCard(
                color1: const Color.fromARGB(255, 5, 20, 36),
                color2: const Color.fromARGB(255, 1, 81, 161),
                title: 'Enviar à Especialista',
                onTap: () {
                  _showModal(context);
                },
              ),
            ),
            Expanded(
              child: CustomCard(
                color1: const Color.fromARGB(255, 0, 0, 0),
                color2: const Color.fromARGB(255, 17, 4, 2),
                title: 'Baixar PDF',
                onTap: () {
                  // Ação para Baixar PDF
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Funções auxiliares (como o modal, edições, etc.) permanecem as mesmas.
}

Widget _buildInfoCard({required String content, required VoidCallback onEdit}) {
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

void _showEditDialog(BuildContext context, String title, String initialValue,
    Function(String) onSave) {
  TextEditingController controller = TextEditingController(text: initialValue);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Editar $title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insira o novo valor',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      onSave(controller.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Salvar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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

void _showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione um Especialista',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Dra. Ana'),
                    subtitle: const Text('Oftalmologista'),
                    leading: const Icon(Icons.medication_liquid),
                    onTap: () {
                      // Lógica para selecionar o Especialista 1
                      Navigator.pop(context); // Fechar o modal
                    },
                  ),
                  ListTile(
                    title: const Text('Dr. Daniel'),
                    subtitle: const Text('Oftalmologista'),
                    leading: const Icon(Icons.medication_liquid),
                    onTap: () {
                      // Lógica para selecionar o Especialista 2
                      Navigator.pop(context); // Fechar o modal
                    },
                  ),
                  ListTile(
                    title: const Text('Dr. João'),
                    subtitle: const Text('Oculista'),
                    leading: const Icon(Icons.remove_red_eye_outlined),
                    onTap: () {
                      // Lógica para selecionar o Especialista 3
                      Navigator.pop(context); // Fechar o modal
                    },
                  ),
                  // Adicione mais especialistas conforme necessário
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
