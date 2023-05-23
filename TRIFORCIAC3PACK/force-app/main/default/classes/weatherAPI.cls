public class weatherAPI {
    public static void retrieve(){
        
        ExternalService.weather service=New ExternalService.weather();
        ExternalService.weather.getWeather_Request req=New ExternalService.weather.getweather_Request();
        req.q='Ankara';
        req.key='4001457782ed4571a56194623230603';
        req.aqi='no';
        ExternalService.weather.getWeather_Response res = service.getWeather(req);
        system.debug(res.Code200.current.tempx5fc);

        
    }
}