trigger DedupeAccount on Account (after insert) {
    
    /* This is technically not built based on best practices, you should not do DML operations (like insert) in a loop.
    Instead, you should make a case list and for each iteration of the loop, add the case to the list.
    Then, as the final step, you should insert the list.
    */
    for (Account a : Trigger.new) {
        Case c = new Case();
        c.Subject = 'Dedupe this account';
        c.AccountId = a.Id;
        c.OwnerId = UserInfo.getUserId();
        insert c;
    }
}