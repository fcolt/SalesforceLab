/**
 * Created by folteanu on 2/28/2022.
 */

public with sharing class WebinarMemberTriggerHandler {
    public static void handleBeforeInsert(List<Webinar_Member__c> newWMembers) {
        validateComment(newWMembers);
        validateRelatedFields(newWMembers);
        validateContactField(newWMembers);
        duplicateRule(newWMembers);
    }

    public static void handleBeforeUpdate(List<Webinar_Member__c> newWMembers) {
        validateComment(newWMembers);
        validateRelatedFields(newWMembers);
        validateContactField(newWMembers);
        duplicateRule(newWMembers);
    }

    private static void validateComment(List<Webinar_Member__c> newWMembers) {
        for (Webinar_Member__c wmember : newWMembers) {
            if (wmember.Status__c.equals('Rejected') && wmember.Comments__c == null)
                wmember.addError('Comment field must be filled');
        }
    }

    private static void validateRelatedFields(List<Webinar_Member__c> newWMembers) {
        for (Webinar_Member__c wmbember : newWMembers) {
            if (wmbember.Related_User__c != null && wmbember.Related_Contact__c != null)
                wmbember.addError('Webinar members can be Contact or User');
        }
    }

    private static void validateContactField(List<Webinar_Member__c> newWMembers) {
        for (Webinar_Member__c wmember : newWMembers) {
            List<Webinar__c> relatedWebinars = [SELECT Type__c FROM Webinar__c WHERE Webinar__c.Id = :wmember.Related_Webinar__c];
            if (wmember.Related_Contact__c != null) {
                for (Webinar__c relatedW : relatedWebinars) {
                    if (relatedW.Type__c != 'External')
                        wmember.addError('Contacts can only be assigned to the webinar if the webinar type is External');
                }
            }
        }
    }

    private static void duplicateRule(List<Webinar_Member__c> newWMembers) {
        Webinar_Member__c[] records = [
                SELECT Related_Contact__c, Related_User__c
                FROM Webinar_Member__c
                WHERE Related_Contact__c != NULL OR Related_User__c != NULL];

        for (Webinar_Member__c wmember : newWMembers) {
            for (Webinar_Member__c rec : records) {
                if ((wmember.Related_Contact__c == rec.Related_Contact__c
                        && wmember.Related_Contact__c != null)
                        || (wmember.Related_User__c == rec.Related_User__c
                        && wmember.Related_User__c != null))
                    wmember.addError('Can\'t have duplicate members');
            }
        }
    }
}