@isTest
public class DedupeAccountTest {
    
    @isTest static void createAccount() {
        Account acc = new Account();
        acc.Name = 'Feel Good Inc.';
        insert acc;
    }
}