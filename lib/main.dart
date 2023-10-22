import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/widgets/tasks.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserTheme(),
      child: MaterialApp(
         theme: ThemeData(
          appBarTheme: const AppBarTheme(elevation: 0),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(background: Colors.red.shade50),
          scaffoldBackgroundColor: const Color.fromARGB(255, 219, 108, 169),
        ),
        home: const Tasks(),
      ),
    ),
  );
}

class UserTheme extends ChangeNotifier {
  int count;
  Color backgroundColor;

  UserTheme({this.count = 5, this.backgroundColor = Colors.black});

  void incrementCount() {
    count++;
    notifyListeners();
  }

  void changeBackgroundColor(Color bgColor) {
    backgroundColor = bgColor;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userTheme = Provider.of<UserTheme>(context);
    // Accès au modèle de données

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: userTheme.backgroundColor,
          child: Center(
            child: Column(
              children: [
                Text(
                  userTheme.count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () {
                    userTheme.incrementCount(); // Appel de la méthode pour incrémenter le compteur
                  },
                  child: const Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    userTheme.changeBackgroundColor(Colors.purple); // Appel de la méthode pour changer la couleur de l'arrière-plan
                  },
                  child: const Text('Change Color'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

