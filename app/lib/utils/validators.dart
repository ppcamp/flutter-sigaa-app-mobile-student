/// validateCPF is a function that is used to check if the [cpf] is a valid one
/// See more in https://dicasdeprogramacao.com.br/algoritmo-para-validar-cpf/
bool validateCPF(String cpf) {
  if (cpf.length != 11) return false;

  final digits = cpf.substring(9); // verifier digits

  int counter = 10;
  double sum = 0;

  // verify the first digit
  for (var i = 0; i < 9; i++) {
    try {
      final v = int.parse(cpf[i]);
      sum += v * (counter - i);
    } catch (e) {
      // if couldn't parse
      return false;
    }
  }
  var digit = (sum * 10) % 11;
  if (digit != int.parse(digits[0])) return false;

  // verifiy the second digit
  counter = 11;
  sum = 0;
  for (var i = 0; i < 10; i++) {
    final v = int.parse(cpf[i]);
    sum += v * (counter - i);
  }
  digit = (sum * 10) % 11;
  if (digit != int.parse(digits[1])) return false;

  return true;
}
