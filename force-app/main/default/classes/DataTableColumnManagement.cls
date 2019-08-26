global with sharing class DataTableColumnManagement
{
    @InvocableMethod(label='Get Column Info')
    global static List<ColumnInfoResult> getColumnInfo(List<ColumnInfoRequest> requests)
    {
        List<ColumnInfoResult> results = new List<ColumnInfoResult>();
        
        for (ColumnInfoRequest request : requests)
        {
            List<DataTableColumnInfo> cols = getColumnInfo(request.objectName, request.fieldNames);
            
            ColumnInfoResult result = new ColumnInfoResult();
            result.objectName = request.objectName;
            result.columnInfo = cols;
            
            results.add(result);
        }
        
        return results;
    }
    
    public static List<DataTableColumnInfo> getColumnInfo(String objectName, String fieldNames)
    {
        List<String> allFields = new List<String>();
        List<DataTableColumnInfo> cols = new List<DataTableColumnInfo>();
        
        for (String loopfield : fieldNames.split(','))
        {
            if (loopfield.trim().length() > 0)
                allfields.add(loopfield.trim());
        }
        
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectName);
        Map<String, Schema.sObjectField> targetFields = targetType.getDescribe().fields.getMap();
        for (String fieldname : allFields)
        {
            if (targetFields.get(fieldname) != null)
            {
                DescribeFieldResult dfr = targetFields.get(fieldname).getDescribe();
                if (dfr.isAccessible()) {
                    DataTableColumnInfo ci = new DataTableColumnInfo();
                    ci.label = dfr.getLabel();
                    ci.fieldName = dfr.getName();
                    Schema.DisplayType fielddataType = dfr.getType();
                    if (fielddataType == Schema.DisplayType.STRING)
                        ci.type = 'text';
                    cols.add(ci);
                }
            }
        }
        
        return cols;
    }
    
    global class ColumnInfoRequest {
        @InvocableVariable(label='Object Name' required=true description='Object Name, API version')
        global String objectName;
        @InvocableVariable(label='Field Names' required=true description='Field Names, comma separated, API versions')
        global String fieldNames;
    }
    
    global class ColumnInfoResult {
        @InvocableVariable(label='Object Name' description='Object Name of the resulting fields/column info')
        global String objectName;
        @InvocableVariable(label='Column Info' description='Column Info, matching the Field Names')
        global List<DataTableColumnInfo> columnInfo;
        
    }
}