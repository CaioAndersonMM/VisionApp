import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionapp/PatientListPage.dart';
import 'package:visionapp/main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ImagePicker _picker = ImagePicker();

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
                      backgroundColor: Color.fromARGB(255, 23, 2, 48), // Branco
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
                    color2: Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Ver imagens',
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomCard(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Opção 3',
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomCard(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: Color.fromARGB(255, 36, 3, 77), // Branco
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
                    color2: Color.fromARGB(255, 36, 3, 77), // Branco
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
                    color2: Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Opção 2',
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomCard2(
                    color1: const Color.fromARGB(255, 0, 123, 255), // Azul
                    color2: Color.fromARGB(255, 36, 3, 77), // Branco
                    title: 'Opção 4',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Últimas capturas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://picsum.photos/200?random=$index'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            color: const Color.fromARGB(255, 173, 216, 230),
                            width: 2),
                      ),
                    );
                  },
                ),
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
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
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
