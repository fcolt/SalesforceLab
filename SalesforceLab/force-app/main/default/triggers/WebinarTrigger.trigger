/**
 * Created by folteanu on 2/28/2022.
 */

trigger WebinarTrigger on Webinar__c (before insert, before update, after update) {
    if(Trigger.isBefore && Trigger.isInsert){
        WebinarTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isUpdate){
        WebinarTriggerHandler.handleBeforeUpdate(Trigger.oldMap, Trigger.newMap);
    }

    /*if(Trigger.isAfter && Trigger.isUpdate){
        WebinarTriggerHandler.handleAfterUpdate(Trigger.oldMap, Trigger.newMap);
    }*/

}