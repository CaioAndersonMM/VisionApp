import 'package:flutter/material.dart';
import 'package:visionapp/PatientDetail.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  // Lista de pacientes para demonstração
  final List<Map<String, dynamic>> patients = [
    {
      'name': 'Maria Aparecida',
      'age': 30,
      'consultationDate': '2024-10-01',
      'isChecked': false,
    },
    {
      'name': 'João Silva',
      'age': 45,
      'consultationDate': '2024-09-28',
      'isChecked': false,
    },
    {
      'name': 'Ana Clara',
      'age': 25,
      'consultationDate': '2024-09-30',
      'isChecked': false,
    },
    {
      'name': 'Carlos Eduardo',
      'age': 50,
      'consultationDate': '2024-10-03',
      'isChecked': false,
    },
    {
      'name': 'Fernanda Lima',
      'age': 40,
      'consultationDate': '2024-10-02',
      'isChecked': false,
    },
    // Adicione mais pacientes conforme necessário
  ];

  String searchQuery = ''; // Variável para armazenar a consulta de busca

  @override
  Widget build(BuildContext context) {
    // Filtrar pacientes com base na consulta de busca
    final filteredPatients = patients.where((patient) {
      return patient['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
        backgroundColor: const Color.fromARGB(255, 1, 19, 39), // Azul
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
            children: [
              // Campo de busca
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value; // Atualiza a consulta de busca
                  });
                },
                decoration: InputDecoration(
                  filled: true, // Preenche o fundo do TextField
                  fillColor: const Color.fromARGB(
                      221, 255, 255, 255), // Cor de fundo branca
                  labelText: 'Buscar paciente',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Bordas arredondadas
                    borderSide: BorderSide.none, // Remove a borda padrão
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Bordas arredondadas
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1), // Borda cinza quando habilitado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Bordas arredondadas
                    borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1), // Borda azul quando focado
                  ),
                  prefixIcon: const Icon(Icons.search), // Ícone de busca
                ),
              ),
              const SizedBox(
                  height: 16.0), // Espaçamento entre o campo de busca e a lista
              filteredPatients.isEmpty // Mensagem se a lista estiver vazia
                  ? Center(
                      child: Text(
                        'Nenhum paciente encontrado.',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredPatients.length,
                        itemBuilder: (context, index) {
                          final patient = filteredPatients[index];
                          return Card(
                            elevation: 5, // Sombra do cartão
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15), // Bordas arredondadas
                            ),
                            color: const Color.fromARGB(
                                255, 255, 255, 255), // Cor do cartão (branco)
                            child: ListTile(
                              leading: const Icon(Icons.person,
                                  size: 40,
                                  color: Color.fromARGB(
                                      255, 0, 123, 255)), // Ícone do paciente
                              title: Text(
                                patient['name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 1, 29,
                                        58)), // Cor do texto do título
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Idade: ${patient['age']}',
                                    style: const TextStyle(
                                        color: Colors.grey), // Cor do subtítulo
                                  ),
                                  Text(
                                    'Data da Consulta: ${patient['consultationDate']}',
                                    style: const TextStyle(
                                        color: Colors.grey), // Cor da data
                                  ),
                                ],
                              ),
                              trailing: Checkbox(
                                value: patient['isChecked'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    patient['isChecked'] =
                                        value; // Atualiza o estado do checkbox
                                  });
                                },
                              ),
                              onTap: () {
                                // Navega para a página de detalhes do paciente
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientDetailsPage(
                                      patientName: patient['name'],
                                      age: patient['age'],
                                      dataconsulta: patient['consultationDate'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
