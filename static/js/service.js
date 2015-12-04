
app.factory('Request', function ($http, $q) {

    function Request() {}

    Request.getAllertes = function () {
        return $http.get("/alertes")
            .success(function (data) {
            }).error(function (data) {
                console.log("error request ")
            }).then(function(data){
                console.log("data receveid: " + data.data);
                return data.data;
            }) ;

    };

    Request.saveNewAlert = function (newAlert) {
        return $http.post("/alertes", angular.toJson(newAlert))
            .success(function (data) {
                console.log("Data send");
            }).error(function () {

            }).then(

        );

    };
    return Request;
});

