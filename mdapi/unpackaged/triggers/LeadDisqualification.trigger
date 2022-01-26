/*
This Trigger is meant to set the status of a Lead to 'Closed - Not Converted' and its rating to 'Cold' if the Lead First or Last Name is (not just contains) 'Test' (case insensitive)
This trigger's code is covered by the HelloWorld trigger's test class
*/

trigger LeadDisqualification on Lead (before insert, before update) {
    for (Lead lead : Trigger.new) {
        // Find out if the Lead's First Name or Last Name field is the value 'Test' case insensitive
        if (lead.FirstName.toLowerCase() == 'test' || lead.LastName.toLowerCase() == 'test') {
            lead.Status = 'Closed - Not Converted';
            lead.Rating = 'Cold';

        }

    }
}