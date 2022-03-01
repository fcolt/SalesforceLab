/**
 * Created by folteanu on 2/28/2022.
 */

trigger WebinarMemberTrigger on Webinar_Member__c (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        WebinarMemberTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isUpdate){
        WebinarMemberTriggerHandler.handleBeforeUpdate(Trigger.new);
    }
}