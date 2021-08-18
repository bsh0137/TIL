exports.handler = async (event) => {
    const message = "Hello from Amplify API!"

    const response = {
        statusCode: 200,
        body: message,
        headers: {
            "Access-Control-Allow-Origin": "*",
        }
    };
    return response;
  };