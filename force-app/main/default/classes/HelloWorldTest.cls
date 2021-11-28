@isTest
public class HelloWorldTest {
	
    @isTest static void updateLead() {

        // To be able to update a lead, we need to first create one
        Lead l = new Lead();

        // The following fields are required so we couldn't create the Lead without them
        l.FirstName = 'Test';
        l.LastName = 'Person';
        l.Company = 'Feel Good Inc.';
        
        // We need to specifically insert the lead as it doesn't exist yet
        insert l;
        
        // We now do a random update, which is what triggers the HelloWorld class
        l.Company = 'Feel Good Inc.';
        update l;
        
    }
}