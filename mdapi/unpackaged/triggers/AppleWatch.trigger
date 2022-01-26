trigger AppleWatch on Opportunity (after insert) {
	// Loop through all opps that enter trigger
    for (Opportunity opp : Trigger.new) {
        
        // Create a new Task, assign to t
        Task t = new Task();
        
        // Fill in the field values
        t.Subject = 'Apple Watch Promo';
        t.Description = 'Send them one ASAP';
        
        // Interesting: Priority is a picklist, but with Apex, you could assign it a value not in the picklist set
        if (opp.Amount > 50000) {
            t.Priority = 'High';
        }
        
        else if (opp.Amount < 10000) {
            t.Priority = 'Low';
        }
        
        else {
            t.Priority = 'Normal';
        }
        
        
        t.WhatId = opp.Id;
        
        // Don't forget the insert statement, otherwise, your record will only exist in the code, not in your database
        insert t;
    }
}