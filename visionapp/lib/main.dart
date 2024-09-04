import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VisionApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.remove_red_eye),
            const SizedBox(width: 10),
            Text(widget.title),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      color: Colors.blue[100],
                      child: InkWell(
                        onTap: _openCamera,
                        child: const Center(
                          child: Text(
                            'Abrir Câmera',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Espaço entre os cards
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      color: Colors.green[100],
                      child: const Center(
                        child: Text(
                          'Opção 2',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Espaço entre os cards
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      color: Colors.purple[100],
                      child: const Center(
                        child: Text(
                          'Opção 3',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Espaço entre os cards
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      color: Colors.orange[100],
                      child: const Center(
                        child: Text(
                          'Opção 4',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
