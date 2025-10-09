

abstract class KeyValueStorageService{

  //Usamos T para definir un tipo de variable generica, lo lee segun el dato que envies.
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);

}
