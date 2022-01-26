@isTest
public class DedupeLeadTest {
    
    @isTest static void createLeadNoDupes() {
        
        // Create a Lead without duplicates
        Lead uniqueLead = new Lead();
        uniqueLead.FirstName = 'Test';
        uniqueLead.LastName = 'Person';
        uniqueLead.Company = 'Feel Good Inc.';
        uniqueLead.Email = 'test@email.com';
        uniqueLead.Description = 'Test Lead for Deduplication Trigger';
        uniqueLead.OwnerId = UserInfo.getUserId();
        insert uniqueLead;

        // Find the inserted lead and the fields that would indicate that it's in the duplicate queue
        Lead updatedLead = [SELECT OwnerId, Description FROM Lead WHERE Id = :uniqueLead.Id];
        System.assertEquals(UserInfo.getUserId(), updatedLead.OwnerId, 'Lead should belong to original creator');
        System.assertEquals(updatedLead.Description, uniqueLead.Description, 'Description should not have changed');


    }

    @isTest static void createLeadManyDupes() {
        
        // Create two Contacts with same email as the lead
        String email = 'test@email.com';

        List<Contact> dupeContacts = new List<Contact>();
        for (Integer i = 0; i< 2; i++)  {
            Contact dupeContact = new Contact();
            dupeContact.FirstName = 'Test';
            dupeContact.LastName = 'Person';
            dupeContact.Email = email;
            dupeContact.OwnerId = UserInfo.getUserId();
            dupeContacts.add(dupeContact);
        }
        
        
        insert dupeContacts;
        System.debug(dupeContacts);

        // Create a new lead with same information
        Lead dupe = new Lead();
        dupe.FirstName = 'Test';
        dupe.LastName = 'Person';
        dupe.Company = 'Feel Good Inc.';
        dupe.Email = email;
        dupe.Description = 'Test Lead for Deduplication Trigger';
        dupe.OwnerId = UserInfo.getUserId();
        insert dupe;
        System.debug(dupe);

        // Test if the owner of the Lead is now the DQ queue and the description was added
        // Get the Data Quality Queue record Id
        Group dataQualityQueue =    [SELECT    Id 
                                    FROM    Group 
                                    WHERE    Type = 'Queue' 
                                    AND    Name = 'Data Quality' 
                                    LIMIT    1];
        
        // Get the dupe lead created earlier (to get the updated owner Id)
        Lead dupeLead = [SELECT OwnerId, Description FROM Lead WHERE Id = :dupe.Id];
        System.debug(dupeLead);

        System.assertEquals(dataQualityQueue.Id, dupeLead.OwnerId, 'Lead was not given to DQ queue');
        System.assert(dupeLead.Description.contains(dupeContacts[0].Id), 'Description does not contain Ids for dupe Contacts');
        System.assert(dupeLead.Description.contains(dupeContacts[1].Id), 'Description does not contain Ids for dupe Contacts');


    }
}