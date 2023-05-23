@RestResource(urlMapping='/hello/*')
global class postmanWebService {
  
    @HttpGet
    global static void test(){
        
        // datatype variableName = Exp. 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;  
        
        String AccounID=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        Account singleAcc =[SELECT Id, Name, Phone, Industry,
                            (SELECT Id, FirstName,LastName, Email, Phone FROM Contacts),
                            (SELECT Id, Name, Amount, CloseDate, StageName FROM Opportunities)
                            FROM Account WHERE Id=:AccounID LIMIT 1];
        
        res.statusCode=200;
        
        Account acc = New Account();
        
        acc.Name=singleAcc.Name;
        acc.Id=singleAcc.Id;
        acc.Phone=singleAcc.Phone;
        acc.Industry=singleAcc.Industry;
        
            
        responseClass rc = New responseClass();
        
        rc.account=acc;
        rc.opportunities=singleAcc.opportunities;
        rc.contacts=singleAcc.contacts;
        
        
        String resStr = JSON.serialize(rc); 
        
        res.responseBody=Blob.valueOf(resStr);
        
        
        // return singleAcc;
      
    }
    
    global class responseClass {
        global Account account;
        global List<Opportunity> opportunities;
        global List<Contact> contacts;
        
    }
 
}











































/*@RestResource(urlMapping='/hello/*')
global  class postmanWebService {
    //SYS A Postman
    //METHOD : GET
    //ENDPOINT : BASEURL + /service/apexrest/hello/*
    //SYS B RestService = REST API (Webservice = SOAP API)
    @HttpGet
    
    global static void test(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        
        String AccountID = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
       Account singleAcc = [SELECT Id,Name,Phone,Industry,(SELECT Id,FirstName,LastName,Email,Phone FROM Contacts),(SELECT Id,Name,Amount,CloseDate,StageName FROM Opportunities)
                           FROM Account WHERE Id=:AccountID LIMIT 1];
        
        res.statusCode=200;
        Account acc = New Account();
        acc.Name=singleAcc.Name;
        acc.id=singleAcc.Id;
        acc.Phone=singleAcc.Phone;
        acc.Industry=singleAcc.Industry;
        
        responseClass rc = New responseClass();
        
           rc.account= acc; 
        	rc.opportunuties=singleAcc.opportunities;
        rc.contacts=singleAcc.contacts;
        
      string resStr = rc.toString();
        res.responseBody=Blob.valueOf(resStr);
        
        
        
        /*string responseBody = '{';
        responseBody+='"account":"hello"';
        responseBody+='"opportunities":'+singleAcc.Opportunities.toString();
        responseBody+='"contacts":'+singleAcc.contacts.toString();
        
        responseBody+='}';
        
        res.responseBody=Blob.valueOf(responseBody);*/
        
        
		//return singleAcc;
    
    
    
    
    
    
    
    
    /*global static Account test(String AccountID){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        
       Account singleAcc = [SELECT Id,Name,Phone,Industry,(SELECT Id,FirstName,LastName,Email,Phone FROM Contacts),(SELECT Id,Name,Amount,CloseDate,StageName FROM Opportunities)
                           FROM Account WHERE Id=:AccountID LIMIT 1];
        
        res.statusCode=200;
		return singleAcc;*/
   /* }
    global class responseClass {
        global Account account;
        global list<opportunity> opportunuties;
       global list<Contact> contacts;
        
        
        
    }

}*/