import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionapp/PatientListPage.dart';
import 'package:visionapp/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, String>> users = [
    {
      'name': 'João da Silva',
      'age': '19 anos',
      'date': '12/12/1976',
      'phone': '(11) 99999-9999',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Maria Oliveira',
      'age': '25 anos',
      'date': '23/04/1980',
      'phone': '(21) 88888-8888',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Carlos Souza',
      'age': '30 anos',
      'date': '15/08/1991',
      'phone': '(31) 77777-7777',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Ana Costa',
      'age': '22 anos',
      'date': '09/10/1999',
      'phone': '(41) 66666-6666',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  late PageController _pageController;
  Timer? _timer;
  int? _expandedIndex; // Armazena o índice do card expandido

  List<bool> _expanded = List.filled(4, false);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 0.8, initialPage: 1); // Ajusta a fração da página
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.round() + 1) %
            users.length; // Loop pela lista
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 1900),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Imagens',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => openCamera(context),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Capturar Imagem'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 23, 2, 48), // Branco
                      foregroundColor: Colors.white, // Cor do texto
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 20.0),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomCard(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: const Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Ver imagens',
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomCard(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: const Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Opção 3',
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomCard(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: const Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Opção 4',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Recursos disponíveis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomCard2(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: const Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Relatório de Pacientes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatientListPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomCard2(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: const Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Cadastrar novo Paciente',
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomCard2(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: const Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Opção 4',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Últimas Consultas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: _expandedIndex != null
                  ? 300
                  : 160, // Altura variável baseada na expansão
              child: PageView.builder(
                controller: _pageController,
                itemCount: users.length *
                    100, // ItemCount maior para simular o infinito
                itemBuilder: (context, index) {
                  final user = users[index % users.length];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Atualiza o índice do card expandido
                        if (_expandedIndex == index % users.length) {
                          _expandedIndex =
                              null; // Fecha o card se ele já estiver aberto
                        } else {
                          _expandedIndex = index % users.length; // Abre o card
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                user['image']!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 105,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            118, 7, 13, 136),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                        '${user['name']}, ${user['age']}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Consulta: ${user['date']}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Telefone: ${user['phone']}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'Mensagens Recentes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openCamera(BuildContext context) async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    if (await Permission.camera.isGranted) {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (photo != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto capturada: ${photo.name}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissão de câmera negada')),
      );
    }
  }
}
