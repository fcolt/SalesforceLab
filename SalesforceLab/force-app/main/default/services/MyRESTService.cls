@RestResource(urlMapping='/testService/v1/*')
global class MyRESTService {

    @HTTPGET
    global static Webinar__c getWebinar() {
        RestRequest req = RestContext.request;

        String webinarId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Webinar__c result = [SELECT Id, Name FROM Webinar__c WHERE Id = :webinarId];
        
        return result;
    }

    @HttpPost
    global static String doPost(String newName) {
        Webinar__c webinar = new Webinar__c();
        webinar.Name = newName;
        insert webinar;
        return webinar.Id;
    }

    @HttpPatch
    global static Webinar__c doPatch(String newName){
        RestRequest req = RestContext.request;
        String webinarId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Webinar__c result = [SELECT Id, Name, Type__c FROM Webinar__c WHERE Id = :webinarId];
        result.Name = newName;
        update result;
        return result;
    }
}
