public with sharing class AuraWebinarController {
    @AuraEnabled
    public static Webinar__c[] getWebinars(String webinarLimit) {
        return [
            SELECT Name, Cost__c, Approval_Status__c, Number_of_Participants__c, Id 
            FROM Webinar__c 
            WHERE Approval_Status__c = 'PENDING'
            ORDER BY Name ASC
            LIMIT :Integer.valueOf(webinarLimit)
        ];
    }

    @AuraEnabled
    public static Webinar__c approveWebinar(Webinar__c webinar){
        try {
            webinar.Approval_Status__c = 'Approved';
            update webinar;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return webinar;
    }

    @AuraEnabled
    public static Webinar__c rejectWebinar(Webinar__c webinar){
        try {
            webinar.Approval_Status__c = 'Rejected';
            update webinar;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return webinar;
    }

    @AuraEnabled
    public static Webinar__c[] getFilteredWebinars(){
        return [
            SELECT Id,Name, Type__c, Status__c, Cost__c, Price_per_participant__c, Number_of_participants__c, Start_Date__c, End_Date__c 
            FROM Webinar__c 
            WHERE Type__c = 'External' AND Approval_Status__c = 'Approved'
        ];
    }

    @AuraEnabled
    public static Integer registerWebinar(Id webinarId){
        try {
            if (webinarId == null) {
                return -1;
            }

            Id userId = UserInfo.getUserId();
            String username = UserInfo.getName();

            Webinar_Member__c webinarMember = new Webinar_Member__c();
            String memberName = username;

            webinarMember.Related_User__c = userId;
            webinarMember.Related_Webinar__c = webinarId;
            webinarMember.Name = memberName; 

            Database.SaveResult res = Database.insert(webinarMember);

            if (res.isSuccess()) {
                return 0;
            }
            return 1;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}