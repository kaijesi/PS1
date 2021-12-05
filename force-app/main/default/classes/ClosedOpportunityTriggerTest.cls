@isTest
public class ClosedOpportunityTriggerTest {
	
    @isTest static void createClosedWonOpp() {
        // Create a closed won opportunity to fire the trigger
        Opportunity opp = new Opportunity();

        // Set required fields
        opp.Name = 'Test';
        opp.CloseDate = Date.today();

        // Set stage name
        opp.StageName = 'Closed Won';

        insert opp;

        // Check if task was filled out properly
        Task checkTask = [SELECT Subject, WhatId FROM Task WHERE WhatId = :opp.Id AND Subject = 'Follow Up Test Task'];
        System.assertEquals('Follow Up Test Task', checkTask.Subject, 'Subject not filled out correctly');
        System.assertEquals(opp.Id, checkTask.WhatId, 'Task not related to correct Opp');


        
    }
}
