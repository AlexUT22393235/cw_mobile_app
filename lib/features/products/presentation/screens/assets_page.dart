import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

import '../screens/general/basic_general_screen.dart';

/// =========================
///  Configuración
/// =========================

// Cambia esto por tu dominio / IP si no es localhost
const String apiBase = "http://localhost:8000";

/// Construye URL absoluta a partir de la ruta en /static
/// y reemplaza espacios por %20 para que la URL sea válida.
String staticUrl(String path) {
  final fixedPath = path.replaceAll(' ', '%20');
  return "$apiBase$fixedPath";
}

/// Un sonido asociado a un personaje o mapa
class AssetSound {
  final String label; // Ej. "Ataque", "Caminar", "Salto"
  final String url;   // URL completa al mp3/wav

  AssetSound({required this.label, required this.url});
}

/// Un personaje con imagen + lista de sonidos
class AssetCharacter {
  final String name;
  final String imageUrl;
  final List<AssetSound> sounds;

  AssetCharacter({
    required this.name,
    required this.imageUrl,
    required this.sounds,
  });
}

/// Un mapa con imagen + (opcional) sonidos de ambiente / combate
class AssetMap {
  final String name;
  final String imageUrl;
  final List<AssetSound> sounds;

  AssetMap({
    required this.name,
    required this.imageUrl,
    required this.sounds,
  });
}

/// =========================
///  Página principal
/// =========================
class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  static const Color coldWarBlue = Color(0xFF33FFC4);

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

enum AssetsTab { personajes, mapas }

class _AssetsPageState extends State<AssetsPage> {
  AssetsTab _selectedTab = AssetsTab.personajes;

  final AudioPlayer _player = AudioPlayer();
  String? _currentSoundUrl;

  // =========================
  //  DATA (ajusta rutas a tu estructura real)
  // =========================

  final List<AssetCharacter> _characters = [
    AssetCharacter(
      name: "Snowy - Guerrero",
      imageUrl: staticUrl("/static/images/personajes/Snowy-Guerrero.png"),
      sounds: [
        AssetSound(
          label: "Ataque",
          url: staticUrl("/static/audio/effects/guerrero/EspadaAtaque1.mp3"),
        ),
        AssetSound(
          label: "Desenvaine",
          url: staticUrl("/static/audio/effects/guerrero/EspadaDesenfunde1.mp3"),
        ),
        AssetSound(
          label: "Daño recibido",
          url: staticUrl("/static/audio/effects/principal/Danio.mp3"),
        ),
        AssetSound(
          label: "Salto",
          url: staticUrl("/static/audio/effects/principal/DashAir.mp3"),
        ),
        AssetSound(
          label: "Dash",
          url: staticUrl("/static/audio/effects/principal/Dash.mp3"),
        ),
        AssetSound(
          label: "Muerte",
          url: staticUrl("/static/audio/effects/principal/MuerteProta.mp3"),
        ),
      ],
    ),
    AssetCharacter(
      name: "Snowy - Mago",
      imageUrl: staticUrl("/static/images/personajes/Snowy-Mago.png"),
      sounds: [
        AssetSound(
          label: "Recarga de mana",
          url: staticUrl("/static/audio/effects/mago/SonidosMago-001.mp3"),
        ),
        AssetSound(
          label: "Ataque",
          url: staticUrl("/static/audio/effects/mago/SonidosMago-002.mp3"),
        ),
        AssetSound(
          label: "Daño recibido",
          url: staticUrl("/static/audio/effects/principal/Danio.mp3"),
        ),
        AssetSound(
          label: "Salto",
          url: staticUrl("/static/audio/effects/principal/DashAir.mp3"),
        ),
        AssetSound(
          label: "Dash",
          url: staticUrl("/static/audio/effects/principal/Dash.mp3"),
        ),
        AssetSound(
          label: "Muerte",
          url: staticUrl("/static/audio/effects/principal/MuerteProta.mp3"),
        ),
      ],
    ),
    AssetCharacter(
      name: "Orca",
      imageUrl: staticUrl("/static/images/personajes/Orca.png"),
      sounds: [
        // agrega sonidos si los tienes
      ],
    ),
    AssetCharacter(
      name: "Rey Pingüino",
      imageUrl: staticUrl("/static/images/personajes/Rey Pinguino.png"),
      sounds: [
        // agrega sonidos si los tienes
      ],
    ),
    AssetCharacter(
      name: "Pingüino Meele",
      imageUrl: staticUrl("/static/images/personajes/Pinguino-Meele.png"),
      sounds: [
        AssetSound(
          label: "Ataque",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoMeele/MeleeAtack.mp3"),
        ),
        AssetSound(
          label: "Daño recibido",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoMeele/DanioMelee.mp3"),
        ),
        AssetSound(
          label: "Presencia",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoMeele/MeleeExisting.mp3"),
        ),
        AssetSound(
          label: "Dash",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoMeele/MeleeDash.mp3"),
        ),
        AssetSound(
          label: "Muerte",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoMeele/MuerteMelee.mp3"),
        ),
      ],
    ),
    AssetCharacter(
      name: "Pingüino Distancia",
      imageUrl: staticUrl("/static/images/personajes/Pinguino-Meele.png"),
      sounds: [
        AssetSound(
          label: "Ataque",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoDist/DistaAtack.mp3"),
        ),
        AssetSound(
          label: "Daño recibido",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoDist/DanioDista.mp3"),
        ),
        AssetSound(
          label: "Presencia",
          url: staticUrl("/static/audio/effects/enemigos/pinguinoDist/DistanceExisting.mp3"),
        ),
      ],
    ),
  ];

  final List<AssetMap> _maps = [
    AssetMap(
      name: "Sonidos de Escenarios",
      imageUrl: "", // sin imagen a propósito
      sounds: [
        AssetSound(
          label: "Plataforma de Hielo Rota",
          url: staticUrl("/static/audio/effects/plataformas/plataformaColapsada.wav"),
        ),
        AssetSound(
          label: "Plataforma de hielo",
          url: staticUrl("/static/audio/effects/plataformas/IceSlice.mp3"),
        ),
        AssetSound(
          label: "Caminata sobre hielo",
          url: staticUrl("/static/audio/effects/plataformas/WalkSnow1.mp3"),
        ),
        AssetSound(
          label: "Caminata sobre piedra",
          url: staticUrl("/static/audio/effects/plataformas/WalkStone1.mp3"),
        ),
        AssetSound(
          label: "Batalla en la Torre",
          url: staticUrl("/static/audio/battle/MainThemeSnowyIII.mp3"),
        ),
        AssetSound(
          label: "Batalla Final",
          url: staticUrl("/static/audio/battle/PeleaFinalSnowy.mp3"),
        ),
        AssetSound(
          label: "Música de Fondo Snowy",
          url: staticUrl("/static/audio/battle/PeleaFinalSnowy.mp3"),
        ),
        AssetSound(
          label: "Victoria Snowy",
          url: staticUrl("/static/audio/status/Win Reforsment.wav"),
        ),
        AssetSound(
          label: "Derrota Snowy",
          url: staticUrl("/static/audio/status/GameOver.wav"),
        ),
      ],
    ),
  ];

  // =========================
  //  Helpers
  // =========================

  Future<void> _downloadFile(String url, {String? suggestedName}) async {
    try {
      final uri = Uri.parse(url);

      // 1. Descargar bytes
      final resp = await http.get(uri);
      if (resp.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al descargar (status: ${resp.statusCode})')),
        );
        return;
      }

      // 2. Obtener carpeta de descargas / documentos
      Directory dir;
      try {
        dir = (await getDownloadsDirectory()) ??
            await getApplicationDocumentsDirectory();
      } catch (_) {
        dir = await getApplicationDocumentsDirectory();
      }

      // 3. Nombre de archivo
      final nameFromUrl = uri.pathSegments.isNotEmpty
          ? uri.pathSegments.last
          : 'asset.bin';
      final fileName = suggestedName ?? nameFromUrl;
      final filePath = '${dir.path}/$fileName';

      // 4. Guardar
      final file = File(filePath);
      await file.writeAsBytes(resp.bodyBytes);

      // 5. Avisar + abrir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Descargado: $fileName')),
      );

      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar archivo')),
      );
    }
  }

  Future<void> _playSound(String url) async {
    if (_currentSoundUrl == url) {
      await _player.stop();
      setState(() {
        _currentSoundUrl = null;
      });
      return;
    }

    await _player.stop();
    await _player.play(UrlSource(url));
    setState(() {
      _currentSoundUrl = url;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  // =========================
  //  UI
  // =========================

  @override
  Widget build(BuildContext context) {
    return BasicContentLayout(
      sectionTitleText: 'ASSETS',
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTabBar(),
            const SizedBox(height: 16),
            if (_selectedTab == AssetsTab.personajes)
              _buildCharactersView()
            else
              _buildMapsView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTabButton("PERSONAJES", AssetsTab.personajes),
        const SizedBox(width: 16),
        _buildTabButton("MAPAS", AssetsTab.mapas),
      ],
    );
  }

  Widget _buildTabButton(String label, AssetsTab tab) {
    final bool selected = _selectedTab == tab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tab;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AssetsPage.coldWarBlue,
            width: 2,
          ),
          color: selected ? AssetsPage.coldWarBlue : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 12,
            color: selected ? Colors.black : AssetsPage.coldWarBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildCharactersView() {
    return Column(
      children: _characters.map(_buildCharacterCard).toList(),
    );
  }

  Widget _buildMapsView() {
    return Column(
      children: _maps.map(_buildMapCard).toList(),
    );
  }

  Widget _buildCharacterCard(AssetCharacter c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AssetsPage.coldWarBlue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            c.name.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: AssetsPage.coldWarBlue,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    c.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _downloadFile(
                  c.imageUrl,
                  suggestedName: '${c.name}.png', // ajusta extensión si hace falta
                ),
                child: const Text(
                  "DESCARGAR IMG",
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Text(
            "SONIDOS",
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 10,
              color: AssetsPage.coldWarBlue,
            ),
          ),
          const SizedBox(height: 6),

          Column(
            children: c.sounds.map(_buildSoundRow).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard(AssetMap m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AssetsPage.coldWarBlue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            m.name.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 12,
              color: AssetsPage.coldWarBlue,
            ),
          ),
          const SizedBox(height: 8),

          // Solo muestra imagen si hay URL
          if (m.imageUrl.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      m.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _downloadFile(
                    m.imageUrl,
                    suggestedName: '${m.name}.png',
                  ),
                  child: const Text(
                    "DESCARGAR IMG",
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

          if (m.imageUrl.isNotEmpty) const SizedBox(height: 12),
          const Text(
            "SONIDOS",
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 10,
              color: AssetsPage.coldWarBlue,
            ),
          ),
          const SizedBox(height: 6),

          Column(
            children: m.sounds.map(_buildSoundRow).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundRow(AssetSound s) {
    final bool isPlaying = _currentSoundUrl == s.url;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AssetsPage.coldWarBlue, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              s.label,
              style: const TextStyle(
                fontFamily: 'PressStart2P',
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _playSound(s.url),
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: AssetsPage.coldWarBlue,
              size: 18,
            ),
          ),
          IconButton(
            onPressed: () => _downloadFile(
              s.url,
              suggestedName: '${s.label}.mp3', // o .wav según el asset
            ),
            icon: const Icon(
              Icons.download,
              color: AssetsPage.coldWarBlue,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
