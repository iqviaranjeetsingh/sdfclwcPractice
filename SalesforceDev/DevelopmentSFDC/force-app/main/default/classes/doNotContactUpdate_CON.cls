public with sharing class doNotContactUpdate_CON {


    public Blob csvFileBody { get; set; }
    Public string csvAsString { get; set; }
    Public Integer updtCount { get; set; }
    Public Integer newRecCount { get; set; }
    Public string message { get; set; }
    Public Boolean showMsgs { get; set; }
    Public Boolean showlist { get; set; }
    Public String[] csvfilelines { get; set; }
    Public String[] inputvalues { get; set; }
    Public List<string> fieldList { get; set; }
    Public List<contact> sObjectList { get; set; }
    Public List<contact> sObjectListInsrt { get; set; }
    public Map<string, contact> conMap ;
    public Map<Id, contact> conMapUpdt ;
    public doNotContactUpdate_CON() {
        csvfilelines = new String[]{
        };
        fieldList = New List<string>();
        sObjectList = New List<sObject>();
        sObjectListInsrt = New List<sObject>();
        showMsgs = true;
        showlist = false;
    }

    public void readcsvFile() {
        
        
        if (csvFileBody != null) {
            conMap = new Map<string, contact>();
            List<Contact> conLst = [SELECT Id, HasOptedOutOfEmail, Email FROM Contact];
            for (contact c : conLst ) {
                conMap.put(c.Email, c);
            }
            csvAsString = csvFileBody.toString(); //EncodingUtil.base64Encode(csvFileBody);
            csvfilelines = csvAsString.split('\n');
            inputvalues = new String[]{};
            for (string st : csvfilelines[0].split(',')) {
                fieldList.add(st);
            }
            for (Integer i = 1; i < csvfilelines.size(); i++) {
                string[] csvRecordData = csvfilelines[i].split(',');
                if (csvRecordData[2] != '') {

                    //csvRecordData[2] = csvRecordData[2].substring(0, csvRecordData[2].indexOf('.com')) + '.com';
                    csvRecordData[2] = csvRecordData[2].toLowerCase();
                    csvRecordData[3] = csvRecordData[3].toLowerCase();
                    if (conMap.containskey(csvRecordData[2])) {
                        contact conRec = new contact();
                        conRec.lastname = csvRecordData[0];
                        conRec.firstname = csvRecordData[1] ;
                        conRec.Email = csvRecordData[2];
                        conRec.HasOptedOutOfEmail = true;//Boolean.valueOf(csvRecordData[3]);
                        conRec.Id = conMap.get(csvRecordData[2]).Id;
                        sObjectList.add(conRec);
                    } else {
                        contact conRecNew = new contact();
                        conRecNew.lastname = csvRecordData[0];
                        conRecNew.firstname = csvRecordData[1] ;
                        conRecNew.Email = csvRecordData[2];
                        conRecNew.HasOptedOutOfEmail = true; //Boolean.valueOf(csvRecordData[3]);
                        sObjectListInsrt.add(conRecNew);
                    }
                }


            }
            system.debug('sObjectList*' + sObjectList.size());
            system.debug('sObjectListInsrt***' + sObjectListInsrt.size());

            if (sObjectList.size() > 0) {
                conMapUpdt = new Map<Id, Contact>();
                for (contact c : sObjectList) {
                    conMapUpdt.put(c.Id, c);
                }
                system.debug('sObjectList***' + sObjectList);
                update conMapUpdt.values();
                showMsgs = false;
                updtCount = conMapUpdt.values().size();
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, updtCount + '  Records Updated Successfully'));
                newRecCount = sObjectListInsrt.size();
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, newRecCount + '  Records are not existing'));
                if (newRecCount > 0) {
                    showlist = true;
                }

            }
            if(sObjectListInsrt.size() > 0 && sObjectList.size() == 0){
                newRecCount = sObjectListInsrt.size();
                updtCount = sObjectList.size();
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, updtCount + '  Records Updated Successfully'));
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, newRecCount + '  Records are not existing'));
                if (newRecCount > 0) {
                    showlist = true;
                }
            }
        } else {
            showMsgs = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Please choose contact CSV file to proceed'));
        }

    }


    public PageReference insertContact() {

        system.debug('sObjectListInsrt***' + sObjectListInsrt);
        insert sObjectListInsrt;
        return null;
    }

}