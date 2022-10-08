
enum ResState{
  success,
  err,
  loading,
}
class BaseRes{
  int? code;
  String? message;
  dynamic data;
  int? total;
  int? pageCount;
  dynamic rows;
  bool isSuccess;
  BaseRes({this.code,this.message,this.data,this.total,this.rows,this.pageCount,this.isSuccess= false});

  factory BaseRes.fromJson(dynamic jsonObj){
    return BaseRes(
      code: jsonObj['code'],
        message: jsonObj['message'],
      data: jsonObj['data'],
      total: jsonObj['total'],
      rows: jsonObj['rows'],
      pageCount: jsonObj['pageCount'],
      isSuccess: jsonObj['code'] == 200
    );
  }
  static BaseRes success({data}){
    return BaseRes(code: 200,message: '操作成功',data: data,isSuccess: true);
  }

  static BaseRes fail({int code = 500,String? msg}){
    return BaseRes(code: code,message: '$msg');
  }


  BaseRes err(String err,{int? code = 203}){
    message = err;
    this.code = code;
    isSuccess = false;
    return this;
  }
  BaseRes cancel(){
    return this;
  }

}

enum LoadState{
  init,
  loading,
  success,
  fail,
}