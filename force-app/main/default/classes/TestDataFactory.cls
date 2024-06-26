public without sharing class TestDataFactory {
  public static String createLeads() {
    String emailAddress = 'handsomes@thehandsomepod.com';
    Lead tig = new Lead(
      LastName = 'Notaro',
      Email = emailAddress,
      Company = 'Taylor Dayne Fan Club'
    );
    Lead fortune = new Lead(
      LastName = 'Feimster',
      Email = emailAddress,
      Company = 'Pretty Little Lady'
    );
    Lead mae = new Lead(
      LastName = 'Martin',
      Email = emailAddress,
      Company = 'Little Cowboy'
    );
    List<Lead> newLeads = new List<Lead>{ tig, fortune, mae };

    insert newLeads;

    System.debug('The list of leads:' + newLeads);

    return emailAddress;
  }

  public static void setUpUser() {
    String uniqueUserName =
      'SystemAdmin' +
      DateTime.now().getTime() +
      '@testorg.com';
    // This code runs as the system user
    Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
    User adminUser = new User(
      Alias = 'Seattle',
      Email = 'adminduser@testorg.com',
      EmailEncodingKey = 'UTF-8',
      LastName = 'Testing',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      ProfileId = p.Id,
      TimeZoneSidKey = 'America/Los_Angeles',
      UserName = uniqueUserName
    );
    insert adminUser;
    User currentUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
    // Insert account as current user
    System.runAs(currentUser) {
      PermissionSet permSet = [
        SELECT Id
        FROM PermissionSet
        WHERE Name = 'Unsubscribe_Link'
      ];
      insert new PermissionSetAssignment(
        AssigneeId = adminUser.Id,
        PermissionSetId = permSet.Id
      );
      System.debug('inserted new perm set assignment');
      System.debug('i got the user id:' + user.id);
    }
  }

  public static void createContacts() {
    String emailAdd = 'waitwait@npr.org';
    Account newA = new Account(Name = 'NPR.org');
    Account newB = new Account(Name = 'KUOW.org');
    Account newC = new Account(Name = 'KCTS9');
    List<Account> newAccounts = new List<Account>{ newA, newB, newC };
    insert newAccounts;

    Contact bob = new Contact(
      LastName = 'Sagal',
      Email = emailAdd,
      AccountId = newA.id
    );
    Contact paula = new Contact(
      LastName = 'Poundstone',
      Email = emailAdd,
      AccountId = newB.id
    );
    Contact maz = new Contact(
      LastName = 'Jobrani',
      Email = emailAdd,
      AccountId = newC.id
    );
    List<Contact> newContacts = new List<Contact>{ bob, paula, maz };
    insert newContacts;
  }

  public static void createBulkContacts() {
    String emailAdd = 'waitwait@npr.org';
    Account newA = new Account(Name = 'NPR.org');
    insert newA;
    List<Contact> cons = new List<Contact>();
    for (Integer i = 0; i < 200; i++) {
      Contact c = new Contact(
        LastName = 'Contact ' + i,
        Email = emailadd,
        AccountId = newA.id
      );
      cons.add(c);
    }
    insert cons;
  }

  public static void createBulkLeads() {
    String emailAdd = 'waitwait@npr.org';
    List<Lead> leads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead l = new Lead(
        LastName = 'Lead ' + i,
        Email = emailadd,
        Company = 'Top Pot Donuts'
      );
      leads.add(l);
    }
    insert leads;
  }
}
