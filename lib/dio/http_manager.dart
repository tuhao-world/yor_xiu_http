

class HttpManager{

  static HttpManager? instance;

  HttpManager._();

  static HttpManager getInstance(){
    if(instance == null){
      instance = HttpManager._();
    }
    return instance!;
  }
}