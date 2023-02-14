class ValidationLogin{
  static bool isValidAccount(String acc){
    return acc!=null && acc.length > 6 && acc.contains("@");
  }
  static bool isValidPassWord(String pass){
    return pass!=null && pass.length>6;
  }
}