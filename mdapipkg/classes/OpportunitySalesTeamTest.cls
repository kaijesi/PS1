@isTest
public class OpportunitySalesTeamTest {
    @isTest static void userHasManager() {
        // Set up user with manager
        User newUser = new User();
        newUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id;
        newUser.LastName = 'test';
        newUser.Email = 'test@feelgoodinc.com';
        newUser.Username = System.currentTimeMillis() + '@testing.com';
        newUser.CompanyName = 'Feel Good Inc';
        newUser.Title = 'title';
        newUser.Alias = 'alias';
        newUser.TimeZoneSidKey = 'America/Los_Angeles';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.LocaleSidKey = 'en_US';
        newUser.ManagerId = System.UserInfo.getUserId();
        insert newUser;

        // Set up an opportunity
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.Amount = 1;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.OwnerId = newUser.Id;
        insert opp;

        // Find out if the manager has been set appropriately
        List<OpportunityTeamMember> oppTeam = [SELECT Id, UserId FROM OpportunityTeamMember WHERE OpportunityId = :opp.Id];
        System.assertEquals(1, oppTeam.size(), 'Opp team should be size 1');
        System.assertEquals(System.UserInfo.getUserId(), oppTeam.get(0).UserId, 'Sales Manager in Opp Team not Manager of Opp Owner');


    }
}
