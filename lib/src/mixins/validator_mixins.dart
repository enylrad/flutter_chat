class ValidatorMixins {

  String validateEmail(String value){
    if(!value.contains('@')){
      return "Email not valid";
    }else{
      return null;
    }
  }

  String validatePassword(String value){
    if(value.length < 6){
      return "Password not valid";
    }else{
      return null;
    }
  }
}