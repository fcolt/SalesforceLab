@isTest
public class TEST_DataFactory {    
    public static Account createTestAccountWithOpp(String AccName, String OppName, Date CloseDate, String StageName, Boolean doInsert) {
        Account acc = createTestAccountWithoutOpp(AccName, true);
        Opportunity opp = new Opportunity(Name=OppName,
                                          CloseDate = CloseDate,
                                          StageName = StageName,
                                          AccountId = acc.Id);

        if (doInsert)
            insert opp;

        return acc;
    }
    public static Account createTestAccountWithoutOpp(String Name, Boolean doInsert) {
        Account acc = new Account(Name=Name);
        if (doInsert)
            insert acc;
        return acc;
    }

    public static Case createCase(String origin, String status, String priority, Boolean doInsert) {
        Case c = new Case(Origin = origin, Status = status, Priority = priority);
        if (doInsert)
            insert c;
        return c;
    }

    public static Contact createContact(String name, Boolean doInsert) {
        Contact con = new Contact(Name = name);
        if (doInsert) 
            insert con;
        return con;
    }
}