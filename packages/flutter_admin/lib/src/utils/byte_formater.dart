abstract class ByteFormatter {
  ByteFormatter._();

  static const _kBytes = 1024;
  static const _mBytes = 1024 * 1024;
  static const _gBytes = 1024 * 1024 * 1024;

  static String fmt(num bytes) {
    final isNegative = bytes < 0;

    if (isNegative) {
      bytes = bytes.abs();
    }

    String resultNumber;
    String symbol;

    if (bytes >= _gBytes) {
      resultNumber = (bytes / _gBytes).toStringAsFixed(1);
      symbol = 'GB';
    } else if (bytes >= _mBytes) {
      resultNumber = (bytes / _mBytes).toStringAsFixed(1);
      symbol = 'MB';
    } else if (bytes >= _kBytes) {
      resultNumber = (bytes / _kBytes).toStringAsFixed(1);
      symbol = 'KB';
    } else {
      resultNumber = bytes.toStringAsFixed(1);
      symbol = 'B';
    }

    if (resultNumber.endsWith('.0')) {
      resultNumber = resultNumber.substring(0, resultNumber.length - 2);
    }

    if (isNegative) {
      resultNumber = '-$resultNumber $symbol';
    }

    return "$resultNumber $symbol";
  }
}
