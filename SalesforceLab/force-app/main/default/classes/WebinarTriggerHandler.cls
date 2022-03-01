/**
 * Created by folteanu on 2/28/2022.
 */

public with sharing class WebinarTriggerHandler {
    public static void handleBeforeInsert(List<Webinar__c> newWebinars) {
        setStatusBasedOnCost(newWebinars);
        setStatusBasedOnApprovalStatus(newWebinars);
        restrictNumberOfParticipants(newWebinars);
        populatePricePerParticipant(newWebinars);
    }

    public static void handleBeforeUpdate(Map<Id,Webinar__c> oldWebinars, Map<Id,Webinar__c> newWebinars) {
        setStatusBasedOnCost(newWebinars.values());
        setStatusBasedOnApprovalStatus(newWebinars.values());
        restrictNumberOfParticipants(newWebinars.values());
        populatePricePerParticipant(newWebinars.values());
        validateStatusChange(oldWebinars, newWebinars); //this should be in before update
    }

    private static void setStatusBasedOnCost(List<Webinar__c> newWebinars) {
        for (Webinar__c web : newWebinars){
            if (web.Cost__c < 100)
                web.Approval_Status__c = 'Approved';
        }
    }

    private static void setStatusBasedOnApprovalStatus(List<Webinar__c> newWebinars) {
        for (Webinar__c web : newWebinars) {
            if (web.Approval_Status__c.equals('Rejected'))
                web.Status__c = 'Canceled';
        }
    }

    private static void restrictNumberOfParticipants(List<Webinar__c> newWebinars) {
        for (Webinar__c web : newWebinars) {
            if (web.Number_of_participants__c > web.Total_number_of_seats__c) {
                web.addError('The number of participants cannot exceed the total number of seats.');
            }
        }
    }

    private static void populatePricePerParticipant(List<Webinar__c> newWebinars) {
        for (Webinar__c web : newWebinars) {
            if (web.Number_of_participants__c != 0)
                web.Price_per_participant__c = web.Cost__c / web.Number_of_participants__c;
            else web.Price_per_participant__c = 0;
        }
    }

    private static void validateStatusChange(Map<Id,Webinar__c> oldWebinars, Map<Id,Webinar__c> newWebinars) {
        for (Webinar__c web : newWebinars.values()) {
            Webinar__c previousWebinar = oldWebinars.get(web.Id);
            if (previousWebinar.Status__c == 'New' && web.Status__c != 'New' && web.Status__c != 'Canceled' && web.Approval_Status__c == 'Pending') {
                if (web.Approval_Status__c.equals('Pending'))
                    web.addError('Approval Status annot be Pending');
            }
        }
    }
}