trigger MultiSelectPicklistChoiceCounter on Account (before insert, before update) {
    for (Account acc : Trigger.new) {
        // Multi-value picklist fields are represented as a semicolon-separated string
        // You can use the .split() operator to give you a list of them 
        Integer flavourCounter = 0;
        if (acc.Ice_Cream_Flavours__c != null) {
            List<String> flavours = acc.Ice_Cream_Flavours__c.split(';');
            // Now fill the flavour counter field on the account with the size of the list
            flavourCounter = flavours.size();
        }
        
        acc.Flavour_Counter__c = flavourCounter;
    }

}