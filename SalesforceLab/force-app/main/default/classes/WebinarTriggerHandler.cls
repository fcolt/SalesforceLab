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
        validateStatusChange(oldWebinars, newWebinars);
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

    // private static HttpResponse getPrice(String endpoint, String externalId) {
    //     HttpRequest req = new HttpRequest();
    //     req.setMethod('GET');

    //     req.setEndpoint(endpoint+externalId);

    //     Http http = new Http();
    //     HttpResponse res;

    //     try {
    //         res = http.send(req);
    //     } catch(System.CalloutException e) {
    //         System.debug(e);
    //     }
    //     return res;
    // }

    // @future (callout = true)
    // private static void setPrice(Set<Id> newWebIds) {
    //     HttpResponse res = new HttpResponse();
    //     List<Webinar__c> webs = [SELECT External_Id__c FROM Webinar__c WHERE Id IN :newWebIds];
    //     for (Webinar__c web : webs) {
    //         res = getPrice('https://calculateprice.getsandbox.com/calculatePrice/', web.External_Id__c);
    //         Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    //         web.Cost__c = (Decimal) m.get('price');
    //         update web;
    //     }
    //     update webs;
    //     // for (Webinar__c nw : newWebinars) {
    //     //     for(Webinar__c old : oldWebinars)
    //     //         if (nw.External_Id__c != old.External_Id__c) {
    //     //             res = getPrice('https://calculateprice.getsandbox.com/calculatePrice/', nw.External_Id__c);
    //     //             Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    //     //             nw.Cost__c = (Decimal) m.get('price');
    //     //         }
    //     //     }
    //     // }
    // }
}