public class ISS {
    public static void position(){
        ExternalService.newISS service = New  ExternalService.newISS();
        
        ExternalService.newISS.issnow_Response res = service.issnow();
        
        system.debug(res.Code200.issx5fposition.latitude);
        system.debug(res.Code200.issx5fposition.longitude);
    
    
  
   /* public static void retrieveposition(){
        string endpoint = 'http://api.open-notify.org/iss-now.json';
        Http http=New Http();
        HttpRequest req = New HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(endpoint);
        
        HttpResponse res = http.send(req);
        if(res.getStatusCode()==200){
            system.debug(res.getBody());
            issdata resBody = (issdata)JSON.deserializeStrict(res.getBody(),issdata.class);
            system.debug(resBody.timestamp);
            system.debug(resBody.iss_position.longitude);
            system.debug(resBody.iss_position.latitude);
        }
    }
    public class issdata {
        public integer timestamp;
        public string message;
        public iss_position iss_position;
        
    }
    
    public class iss_position{
        public string latitude;
        public string longitude;
    }*/
}
}