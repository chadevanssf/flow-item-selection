global with sharing class ItemSelectorListController {
    @AuraEnabled
    public static List<SObject> getResults(String objectName, String fieldNames)
    {
        System.debug('ItemSelectorListController.getResults: ' + objectName + '; ' + fieldNames);
        List<String> allFields = new List<String>();
        String cleanFieldNames = '';
        String rawFieldName = fieldNames + ',id,name';
        
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectName);
        Map<String, Schema.sObjectField> targetFields = targetType.getDescribe().fields.getMap();
        
        for (string loopfield : rawFieldName.split(','))
        {
            String finalFieldName = loopfield.trim().toLowerCase();
            if (finalFieldName.length() > 0 
                && !allFields.contains(finalFieldName)
                && targetFields.get(finalFieldName).getDescribe().isAccessible())
            {
                allfields.add(finalFieldName);
            }
        }
        cleanFieldNames = String.join(allfields, ',');
        
        return Database.query('SELECT ' + cleanFieldNames + ' FROM ' + objectName);
    }
    
    @AuraEnabled(cacheable=true)
    public static List<DataTableColumnInfo> getFieldTypes(string objectName, string fieldNames)
    {
        System.debug('ItemSelectorListController.getFieldTypes: ' + objectName + '; ' + fieldNames);
        
        List<DataTableColumnInfo> cols = DataTableColumnManagement.getColumnInfo(objectName, fieldNames);
                
        return cols;
    }
}