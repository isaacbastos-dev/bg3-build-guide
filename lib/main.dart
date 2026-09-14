import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'screens/class_detail_screen.dart';
import 'models/bg3_class.dart';
import 'services/class_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF12100E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC6A15B),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF12100E),
          foregroundColor: Color(0xFFE8D7B0),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ClassService classService = ClassService();
  final AudioPlayer audioPlayer = AudioPlayer();

  List<Bg3Class> classes = [];
  bool carregando = true;
  bool musicaTocando = false;

  @override
  void initState() {
    super.initState();
    carregarClasses();
    tocarMusica();
  }

  Future<void> tocarMusica() async {
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.setVolume(0.25);

    try {
      await audioPlayer.play(
        AssetSource('audio/golden_brown.mp3'),
      );

      if (mounted) {
        setState(() {
          musicaTocando = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          musicaTocando = false;
        });
      }
    }
  }

  Future<void> alternarMusica() async {
    if (musicaTocando) {
      await audioPlayer.pause();

      if (mounted) {
        setState(() {
          musicaTocando = false;
        });
      }
    } else {
      await audioPlayer.play(
        AssetSource('audio/golden_brown.mp3'),
      );

      if (mounted) {
        setState(() {
          musicaTocando = true;
        });
      }
    }
  }

  Future<void> carregarClasses() async {
    final resultado = await classService.carregarClasses();

    setState(() {
      classes = resultado;
      carregando = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BG3 Build Guide'),
        actions: [
          IconButton(
            onPressed: alternarMusica,
            icon: Icon(
              musicaTocando
                  ? Icons.volume_up
                  : Icons.volume_off,
              color: const Color(0xFFC6A15B),
            ),
          ),
        ],
      ),
      body: carregando
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classe = classes[index];

          return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              color: const Color(0xFF1D1915),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color(0xFF3A3024),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Image.asset(
                  classe.imagem,
                  width: 52,
                  height: 52,
                ),
                title: Text(
                  classe.nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE8D7B0),
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFC6A15B),
                ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassDetailScreen(
                    classe: classe,
                  ),
                ),
              );
            },
          ),
          );
        },
      ),
    );
  }
}