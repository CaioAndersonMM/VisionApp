import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VisionApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              const Color.fromARGB(255, 255, 253, 253), // Cor base para o tema
          primary: const Color.fromARGB(255, 0, 0, 0), // Cor da AppBar
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'VisionApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            const Icon(Icons.remove_red_eye, color: Colors.black),
            const SizedBox(width: 10),
            Text(widget.title, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 1, 16, 28),
              Color.fromARGB(255, 4, 4, 116),
              Color.fromARGB(255, 28, 0, 103)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.fromLTRB(26, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft, // Alinha o texto à esquerda
                child: Text(
                  'Imagens',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                      child: ElevatedButton.icon(
                        onPressed: _openCamera,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Analisar Imagem'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 3, 4, 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 26.0, horizontal: 14.0),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Remove o arredondamento
                          ),
                        ),
                      ),
                    ),
                    CustomCard(
                      color1: const Color.fromARGB(255, 3, 3, 3),
                      color2: const Color.fromARGB(255, 35, 4, 173),
                      title: 'Ver imagens',
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomCard(
                      color1: const Color.fromARGB(255, 3, 3, 3),
                      color2: const Color.fromARGB(255, 35, 4, 173),
                      title: 'Opção 3',
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomCard(
                      color1: const Color.fromARGB(255, 3, 3, 3),
                      color2: const Color.fromARGB(255, 35, 4, 173),
                      title: 'Opção 4',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 26.0),
              child: Align(
                alignment: Alignment.centerLeft, // Alinha o texto à esquerda
                child: Text(
                  'Recursos disponíveis',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCard2(
                      color1: const Color.fromARGB(255, 8, 2, 2),
                      color2: const Color.fromARGB(255, 44, 18, 245),
                      title: 'Opção 1',
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomCard2(
                      color1: const Color.fromARGB(255, 8, 2, 2),
                      color2: const Color.fromARGB(255, 44, 18, 245),
                      title: 'Opção 2',
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomCard2(
                      color1: const Color.fromARGB(255, 8, 2, 2),
                      color2: const Color.fromARGB(255, 44, 18, 245),
                      title: 'Opção 4',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.fromLTRB(26, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft, // Alinha o texto à esquerda
                child: Text(
                  'Últimas capturas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
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
            // padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15, color: Colors.white),
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
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            // padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
