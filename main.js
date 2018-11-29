// test cloud function
Parse.Cloud.define("test", function(request, response) {
    var text = "hello world";
    var jsonObject = {
        "answer": text
    };
    response.success(jsonObject);
});
