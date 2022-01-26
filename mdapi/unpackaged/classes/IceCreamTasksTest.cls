@isTest
public class IceCreamTasksTest {
	
    @isTest static void createAccountMultipleTasks() {
        Account acc = new Account();
        acc.Name = 'Test';
        // The created account has to have at least one ice cream flavour selected for all lines of code to run
        acc.Ice_Cream_Flavours__c = 'Strawberry;Chocolate';
        insert acc;

        // Find out if two cases were created
        List<Task> sampleTasks = [SELECT Priority, Subject, WhatId FROM Task WHERE WhatId = :acc.Id];
        System.assertEquals(2, sampleTasks.size(), 'List should contain two tasks');

        // Sort the list items (Chocolate should be first then)
        sampleTasks.sort();

        // For each task, check if the fields were correctly filled out
        for (Task task : sampleTasks) {
            System.assertEquals('Normal', task.Priority, 'Task priority incorrect');
            System.assertEquals(acc.Id, task.WhatId, 'Account reference incorrect');
            if (task == sampleTasks.get(0))  {
                System.assertEquals('Send customer Test a sample of Chocolate ice cream!', task.Subject, 'Subject incorrect');
            }
            else    {
                System.assertEquals('Send customer Test a sample of Strawberry ice cream!', task.Subject, 'Subject incorrect');
            }

        }

    }
}