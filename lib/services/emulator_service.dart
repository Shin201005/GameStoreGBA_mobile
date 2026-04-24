class EmulatorService {
  static String buildGameUrl(String rom) {
    return 'http://10.0.2.2/gba/index.html?rom=$rom';
  }
}
