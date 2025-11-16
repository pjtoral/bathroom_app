import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'URL')
  static final String url = _Env.url;

  @EnviedField(varName: 'ANON_KEY')
  static final String anonKey = _Env.anonKey;
}
