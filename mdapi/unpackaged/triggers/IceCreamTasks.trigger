// Needs after insert as we need Account ID later on
trigger IceCreamTasks on Account (after insert, before update) {
    for (Account acc : Trigger.new) {
        // Find out how many ice cream flavours were selected
        List<String> flavours;

        if (acc.Ice_Cream_Flavours__c != null)  {
            flavours = acc.Ice_Cream_Flavours__c.split(';');
        }
        
        // Only proceed if at least one flavour was selected
        if (flavours != null) {
            // Set up a list of tasks to insert
            List<Task> sendSampleTasks = new List<Task>();
            // Set up one task per flavour in which you ask the current user to send a sample of that ice cream to the account, add to list to be inserted
            for (String flavour : flavours) {
                Task sendSample = new Task();
                sendSample.Priority = 'Normal';
                sendSample.Subject = 'Send customer ' + acc.Name + ' a sample of ' + flavour + ' ice cream!';
                sendSample.WhatId = acc.Id;
                sendSample.OwnerId = UserInfo.getUserId();
                sendSampleTasks.add(sendSample);
            }
            
            // Insert all tasks
            insert sendSampleTasks;
        }
    }

}