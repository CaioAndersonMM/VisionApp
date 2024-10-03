import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionapp/PatientDetail.dart';
import 'package:visionapp/PatientListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oftalcare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 123, 255), // Azul
          primary: const Color.fromARGB(255, 0, 123, 255), // Azul
          secondary: Color.fromARGB(255, 255, 255, 255), // Branco
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 1, 29, 58), // Azul
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Oftalcare'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();

  void _openCamera() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.remove_red_eye, color: Colors.white),
            const SizedBox(width: 10),
            Text(widget.title, style: const TextStyle(color: Colors.white)),
          ],
        ),
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
                      onPressed: _openCamera,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Analisar Imagem'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 36, 3, 77), // Branco
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                                    builder: (context) => const PatientListPage(), // Navega para a nova tela
                          ),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String title;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.color1,
    required this.color2,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard2 extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String title;
  final VoidCallback onTap;

  const CustomCard2({
    super.key,
    required this.color1,
    required this.color2,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
