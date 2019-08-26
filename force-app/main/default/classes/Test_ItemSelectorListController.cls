@IsTest
public class Test_ItemSelectorListController {
    @isTest
    static void testGetResults()
    {
        List<SObject> objs = ItemSelectorListController.getResults('Account', 'AccountSource');
        
        System.assertNotEquals(null, objs);
    }
    
    @isTest
    static void testGetFieldTypes()
    {
        List<ItemSelectorListController.ColumnInfo> cols = ItemSelectorListController.getFieldTypes('Account', 'AccountSource');
        
        System.assertNotEquals(null, cols);
    }
    
    @testSetup
    static void testSetupCoreObjects()
    {
        Account a = new Account();
        a.Name = 'Pizza King';
        insert a;
    }
}