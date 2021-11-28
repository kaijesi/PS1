trigger LeadingCompetitor on Opportunity (before insert, before update) {
    for (Opportunity opp : Trigger.new) {
        String leadingCompetitor;
        if (opp.Competitor_1_Price__c < opp.Competitor_2_Price__c && opp.Competitor_1_Price__c < opp.Competitor_3_Price__c) {
            leadingCompetitor = opp.Competitor_1__c;
        }
        else if (opp.Competitor_2_Price__c < opp.Competitor_3_Price__c && opp.Competitor_2_Price__c < opp.Competitor_3_Price__c) {
            leadingCompetitor = opp.Competitor_2__c;
        }
        else {
            leadingCompetitor = opp.Competitor_3__c;
        }
        opp.Leading_Competitor__c = leadingCompetitor;
    }

}