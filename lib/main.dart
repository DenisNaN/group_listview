import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group ListView',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Group ListView'),
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
  Map<String, int> header = {};
  List students = [];

  @override
  Widget build(BuildContext context) {
    header.clear(); // Для горячей перезагрузки
    students.clear(); // Для горячей перезагрузки

    Student student1 = Student('Николай', 23, 'Москва');
    Student student2 = Student('Константин', 21, 'Санкт-петербург');
    Student student3 = Student('Денис', 19, 'Москва');
    Student student4 = Student('Евгений', 25, 'Новгород');
    Student student5 = Student('Степан', 23, 'Санкт-петербург');
    Student student6 = Student('Андрей', 30, 'Санкт-петербург');
    Student student7 = Student('Владимир', 22, 'Новгород');
    Student student8 = Student('Виталий', 29, 'Москва');
    students.add(student1);
    students.add(student2);
    students.add(student3);
    students.add(student4);
    students.add(student5);
    students.add(student6);
    students.add(student7);
    students.add(student8);

    students.sort((a, b) => a.city.compareTo(b.city));

    header['Москва'] = -1;
    header['Санкт-петербург'] = -1;
    header['Новгород'] = -1;


    int index = students.length - 1;
    for(int i = students.length - 1; i >= 0; i--){
      header[students[i].city] = index--;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: students.length,
          itemBuilder:  (context, index) {
            return Column(children: [

              index == header[students[index].city] ?
              _getTextHeader(index) : const SizedBox.shrink(),

              ListTile(
                  tileColor: Colors.yellow.shade200,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text.rich(TextSpan(children: [
                    TextSpan(text: '№ ${students[index].name} '),
                    TextSpan(text: 'Возраст: ${students[index].age}. ', style: const TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  subtitle: Text('Город: ${students[index].city}')
              )
            ]);
          })
    );
  }

  Container _getTextHeader(int index){
    return Container(width: double.maxFinite, height: 30, alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.indigoAccent, Colors.blue]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(2, 4), // Shadow position
            ),
          ]),
      child: Text('${students[index].city}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: Colors.white)),
    );
  }
}

class Student{
  late String name;
  late int age;
  late String city;

  Student(this.name, this.age, this.city);
}

