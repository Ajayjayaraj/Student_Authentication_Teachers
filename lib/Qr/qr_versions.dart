class QrVersions {
  static const int auto = -1;

  static const int min = 1;

  static const int max = 40;

  static bool isSupportedVersion(int version) =>
      version == auto || (version >= min && version <= max);
}
