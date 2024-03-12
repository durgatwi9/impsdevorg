@isTest(seeAlldata = false)
public class ContactTriggerSrikantSirTest {   
    
    @isTest
    public static void doTesting(){
        
        Test.startTest();
        Account acnt = new Account();
        acnt.Name = 'TEST APEX Account';
        acnt.Rating = 'Hot';
        insert acnt;
        
        contact con = new contact();
        con.LastName = 'TEST APEX CONTACT';
        con.AccountId = acnt.id;
        insert con;
        Test.stopTest();
        
        //check results//
        Account acntRecord = [Select Id, Total_No_Contacts__c From Account];
        system.assertEquals(1, acntRecord.Total_No_Contacts__c, 'count mismatched');
    }
    
    @isTest
    public static void doTestingforUpdate(){

        Test.startTest();
        List<Account> acntList = new List<Account>();
        Account acnt = new Account();
        acnt.Name = 'TEST APEX Account';
        acnt.AccountNumber = 'SAP567';
        acnt.Rating = 'Hot';
        
        acntList.add(acnt);
        
        Account acnt2 = new Account();
        acnt2.Name = 'TEST APEX Account2';
        acnt2.AccountNumber = 'SAP5672';
        acnt2.Rating = 'Hot';
        acntList.add(acnt2);
        
        insert acntList;
        
        contact con = new contact();
        con.LastName = 'TEST APEX CONTACT';
        con.AccountId = acntList[0].id;
        insert con;
        
        //updating contact 
        contact updateCon = new contact();
        updatecon.id = con.id;    // assign old id to new through update
        updatecon.AccountId = acntList[1].id;
        update updatecon;
        
        Test.stopTest();
        //check results//
        List<Account> acntRecord = [Select Id, Total_No_Contacts__c From Account];
        system.assertEquals(1, acntRecord[1].Total_No_Contacts__c, 'count mismatched');
        system.assertEquals(0, acntRecord[0].Total_No_Contacts__c, 'count mismatched');
    }
    
    @isTest
    public static void doTestingforDelete(){
        Test.startTest();
        Account acnt = new Account();
        acnt.Name = 'TEST APEX Account';
        acnt.AccountNumber = 'SAP567';
        acnt.Rating = 'Hot';
        insert acnt;
        
        contact con = new contact();
        con.LastName = 'TEST APEX CONTACT';
        con.AccountId = acnt.id;
        insert con;
        //check results//
        Account acntRecord = [Select Id, Total_No_Contacts__c From Account];
        system.assertEquals(1, acntRecord.Total_No_Contacts__c, 'count mismatched');
        
        
        delete con;
        Test.stopTest();
        
        Account acntRecordAfterDelete = [Select Id, Total_No_Contacts__c From Account];
        system.assertEquals(0, acntRecordAfterDelete.Total_No_Contacts__c, 'count mismatched');
        
        undelete con;
    }
    
    
}