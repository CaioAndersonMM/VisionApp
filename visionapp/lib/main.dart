import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visionapp/HomeScreen.dart';
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
          secondary: const Color.fromARGB(255, 255, 255, 255), // Branco
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 1, 9, 19), // Azul escuro
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 0, 0, 0), // Preto
          selectedItemColor: Color.fromARGB(255, 1, 119, 255), // Azul
          unselectedItemColor: Color.fromARGB(255, 20, 1, 1), // Branco
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
  int _selectedIndex = 0; // Índice do item selecionado na barra de navegação

  // Lista de widgets correspondentes às telas
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(), // Instanciação do HomeScreen
      const PatientListPage(), // Lista de pacientes
      const ChatScreen(), // Tela de chat
      const SettingsScreen(), // Tela de configurações
    ]);
  }

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: _pages[
          _selectedIndex], // Exibe a tela correspondente ao índice selecionado
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 1, 9, 19),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Ícone do chat
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Classe ChatScreen (a ser implementada)
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Tela de Chat', style: TextStyle(color: Colors.white)));
  }
}

// Classe SettingsScreen (a ser implementada)
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Tela de Configurações',
            style: TextStyle(color: Colors.white)));
  }
}

// As classes CustomCard e CustomCard2 permanecem as mesmas
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
  final Color color1; // Cor do início do gradiente
  final Color color2; // Cor do final do gradiente
  final String title; // Título do card
  final VoidCallback onTap; // Função a ser chamada ao tocar no card

  const CustomCard2({
    Key? key,
    required this.color1,
    required this.color2,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Largura do card
      height: 150, // Altura do card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Bordas arredondadas
        ),
        child: InkWell(
          onTap: onTap, // Ação ao tocar no card
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2], // Cores do gradiente
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15), // Bordas arredondadas
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Padding interno
                child: Text(
                  title, // Texto do título
                  style: const TextStyle(
                      fontSize: 15, color: Colors.white), // Estilo do texto
                  textAlign: TextAlign.center, // Centraliza o texto
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
