trigger OpportunitySalesTeam on Opportunity (after insert) {

    for (Opportunity opp : Trigger.new) {
        // Find out who the Opportunity Owner & their Manager is
        User owner = [SELECT Id, ManagerId FROM User WHERE Id = :opp.OwnerId];
        System.debug('Manager found: ' + owner);
        // Create an OpportunityTeamMember record for the manager
        if (owner.ManagerId != null) {
            OpportunityTeamMember managerMember = new OpportunityTeamMember();
            managerMember.OpportunityId = opp.Id;
            managerMember.TeamMemberRole = 'Sales Manager';
            managerMember.UserId = owner.ManagerId;
            insert managerMember;

        }
    }

}