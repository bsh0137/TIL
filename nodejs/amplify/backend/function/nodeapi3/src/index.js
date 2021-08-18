exports.handler = async (event) => {
    // const message = "Hello from Amplify API!"

    var request=require('request');
    request('http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=D3yLGqvjvtXsLVdiFT2gvQkoG3rU4kEdFcNgnCok4x3jSg683X%2B3KnSw%2Bgd5vGu4Qn9jIlQ06tL%2BTXu9fOK7eA%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20210817&endCreateDt=20210817',function(error, response, body){
    if(!error&&response.statusCode==200)
    console.log(body);
    });
    const message = body;

    const response = {
        statusCode: 200,
        body: message,
        headers: {
            "Access-Control-Allow-Origin": "*",
        }
    };
    return response;
  };