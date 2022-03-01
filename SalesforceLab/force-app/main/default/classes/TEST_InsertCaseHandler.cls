/**
 * Created by folteanu on 3/1/2022.
 */

@IsTest
private class TEST_InsertCaseHandler {
    @IsTest
    static void whenOpenCase() {
        Case c = TEST_DataFactory.createCase('Email', 'Open', 'Medium', true);

        Test.startTest();
        InsertCaseHandler.updateCase(c);
        Test.stopTest();

        System.assert(c.Priority == 'Low');
    }
    @IsTest
    static void whenNotOpenCase() {
        Case c = TEST_DataFactory.createCase('Email', 'Approved', 'Low', true);

        Test.startTest();
        InsertCaseHandler.updateCase(c);
        Test.stopTest();

        System.assert(c.Priority == 'Medium');
    }
}