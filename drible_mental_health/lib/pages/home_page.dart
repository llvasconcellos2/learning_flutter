import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuário'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  // Greetings Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // hi Leo!
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Oi, Leonardo!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            DateFormat(
                              'dd/MM/yyyy HH:mm',
                            ).format(DateTime.now()),
                            style: TextStyle(color: Colors.blue.shade100),
                          ),
                        ],
                      ),

                      //Notification
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.notifications, color: Colors.white),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  //Search Bar
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 5),
                        Text('Busca', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  //How do you feel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Como você se sente?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.more_horiz, color: Colors.white),
                    ],
                  ),

                  SizedBox(height: 25),

                  // 4 Face Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text('😞', style: TextStyle(fontSize: 28)),
                          ),
                          SizedBox(height: 5),
                          Text('Ruim', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text('🙂', style: TextStyle(fontSize: 28)),
                          ),
                          SizedBox(height: 5),
                          Text('Bem', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text('😁', style: TextStyle(fontSize: 28)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Muito Bem',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text('😀', style: TextStyle(fontSize: 28)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Excelente',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(25),
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Column(
                      children: [
                        // Exercise heading
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Exercícios',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.more_horiz),
                          ],
                        ),

                        SizedBox(height: 20),

                        //Listview of exercises
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text('Habilidades de Fala'),
                                    subtitle: Text('15 Exercícios'),
                                    trailing: Icon(Icons.more_horiz),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text('Habilidades de Leitura'),
                                    subtitle: Text('8 Exercícios'),
                                    trailing: Icon(Icons.more_horiz),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text('Habilidades de Escrita'),
                                    subtitle: Text('15 Exercícios'),
                                    trailing: Icon(Icons.more_horiz),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
