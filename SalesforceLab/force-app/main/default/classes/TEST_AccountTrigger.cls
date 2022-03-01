@isTest
public class TEST_AccountTrigger {
    @TestSetup
    public static void testSetup() {
    }
    @isTest
    private static void deleteAccWithOppTriggerTest() {
       	Account acc = TEST_DataFactory.createTestAccountWithOpp(
                'TestAcc',
                'TestOpp',
                Date.today(),
                'Prospecting',
                True
        );
        Test.startTest();
        	Database.DeleteResult res = Database.delete(acc,false);
        Test.stopTest();
        
        System.assert(!res.isSuccess());
        System.assert(res.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', res.getErrors()[0].getMessage());
    }
    @isTest
    private static void deleteAccWithoutOppTriggerTest() {
       	Account acc = TEST_DataFactory.createTestAccountWithoutOpp('Test', True);
        Test.startTest();
        	Database.DeleteResult res = Database.delete(acc,false);
        Test.stopTest();
        
        System.assert(res.isSuccess());  
    }
}