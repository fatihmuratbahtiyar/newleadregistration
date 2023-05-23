@restResource(urlMapping='/Zoom/Webhook/*')
global class ZoomWebService {
    
   
    
    
    @HttpGet
    global static string getHandler(){
        
        return 'Hello Zoom Service';
    }
    
 
    
    @httpPost
    global static void postHandler(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        
        
        Map<String,Object> eventMap = (Map<String,Object>) JSON.deserializeUntyped(req.requestBody.toString());
        
        Map<String,Object> payloadMap = (Map<String,Object>) eventMap.get('payload');
        
        Map<String,Object> ObjectMap = (Map<String,Object>) payloadMap.get('object');
        
        String eventtype = eventMap.get('event').toString();
        
        zoomlog__c zoomlog = New zoomlog__c();
        zoomlog.body__c=req.requestBody.toString();
        zoomlog.event__c=eventMap.get('event').toString(); 
        
        insert zoomlog;  
        
        switch on eventtype {
            when 'meeting.created' {        // when block 1
                String ZoomURL = ObjectMap.get('join_url').toString();
                String Topic = ObjectMap.get('topic').toString();
                String start_time = ObjectMap.get('start_time').toString();
                
                Id intId = Topic.split('\\$')[0];
                
                zoomlog__c createLog = New zoomlog__c();
                createLog.body__c = ZoomURL;
                createLog.event__c = Topic;
                insert createLog;
                
                start_time = start_time.replace('T', ' ');
                Datetime zoomTime = Datetime.valueof(start_time);
                
                if(String.valueOf(intId.getSObjectType())=='Interview__c'){
                    Interview__c interview = New Interview__c();
                    interview.id=intId;
                    interview.Meeting_URL__c=ZoomURL;
                    interview.Scheduled_DateTime__c = zoomTime;
                    interview.Status__c = 'Scheduled';
                    update interview;
                }
                                
                
            }   
            when 'meeting.deleted' {        // when block 2
                
                String TopicDelete = ObjectMap.get('topic').toString();
                
                
            }
            when 'endpoint.url_validation' {        // when block 3
                reqData reqApex = (reqData)JSON.deserialize(req.requestBody.toString(), reqData.class);   
                
                resData resData = New resData(); 
                
                String encryptedToken ='';  
                
                
                zoomlog__c zoomverify = New zoomlog__c();
                zoomverify.body__c=req.requestBody.toString();
                zoomverify.event__c=reqApex.event; 
                
                insert zoomverify; 
                
                Blob webhookToken = Blob.valueOf('BhIuYqfxR9Kh_JURFzYc6Q');
                Blob plainToken = Blob.valueOf(reqApex.payload.plainToken);
                
                Blob hmac = Crypto.generateMac('HmacSHA256', plainToken, webhookToken);
                
                encryptedToken=EncodingUtil.convertToHex(hmac);
                
                resData.plainToken = reqApex.payload.plainToken;
                resData.encryptedToken = encryptedToken;
                
                res.statusCode=200;
                res.addHeader('Content-Type', 'application/json');
                res.responseBody=Blob.valueOf(JSON.serialize(resData));
                
                
                
            }
            when else {       // default block, optional
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    global class reqData {
        global payload payload;
        global String event_ts;
        global String event;  
    }
    
    global class payload {
        Global String plainToken;
        
    }
    
    global class resData {
        Global String plainToken;
        Global String encryptedToken;
    }
    























/*https://clarusway228-dev-ed.develop.my.salesforce.com/    /Zoom/Webhook/
guestuser oluşturulmalı clarusway228-dev-ed.develop.my.salesforce-sites.com/services/apexrest/Zoom/Webhook/ bu getuserin adresiVF PAGE Webhook yapıp guest user ile çalışcaz

 clientid:   ZwiGq0AdSJGzRODmLxK90ACopy
 secret:     Dro2n2l7jJgtHxj6x2llzHL25Qv7qrqg
 https://zoom.us/oauth/authorize

 https://zoom.us/oauth/token
 auth provider  :  https://clarusway228-dev-ed.develop.my.salesforce.com/services/authcallback/zoom
 
 
 webhook token:   BhIuYqfxR9Kh_JURFzYc6Q
 verification token n (Retires in October 2023) :   OO2zOPMzQW-8xlhxIk8TWA*/
}