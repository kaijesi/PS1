// Trigger should fire whenever a case is created
trigger WarrantySummary on Case (before insert) {
    for (Case c : Trigger.new) {
        
        // Set a string that shows the formatted Purchase Date
        String purchaseDate             = c.Product_Purchase_Date__c.format();
        
        // Set a string that shows the formatted record creation time (although not using the created date, just now())
        String createdDate              = DateTime.now().format();
        
        /* Set an integer that shows the total number of days on the warranty
        Number fields are decimals by default, so if you want to show this as an integer, make sure to use intValue() */
        Integer warrantyDays            = c.Product_Total_Warranty_Days__c.intValue();

        /* Calculate the percentage of warranty days passed between purchase date and today
        To not write out a lot of decimals, use setScale(2) to make sure only 2 decimals are shown */
        Decimal warrantyPercentage      = (100 * (c.Product_Purchase_Date__c.daysBetween(Date.today()) / c.Product_Total_Warranty_Days__c)).setScale(2);
        
        // Show whether the warranty is marked as extended
        Boolean hasExtendedWarranty     = c.Product_Has_Extended_Warranty__c;
        
        // Build out the summary field from these values
        c.Warranty_Summary__c = 'Product purchased on ' + purchaseDate + ' ' +
                                'and case created on ' + createdDate + '\n' +
                                'Warranty is for ' + warrantyDays + ' Days ' +
                                'and is ' + warrantyPercentage + '% through its warranty period.\n' +
                                'Extended warranty: ' + hasExtendedWarranty + '\n' +
                                'Have a nice day!';
    }
}