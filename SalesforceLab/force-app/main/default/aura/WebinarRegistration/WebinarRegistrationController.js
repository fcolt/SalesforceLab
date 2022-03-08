({
    doInit : function(component, event, helper) {
        const actions = [
            {label: 'Register', name: 'register'},
        ];
        component.set("v.columns", [
            {'label' : 'Id', 'fieldName': 'Id', 'type' : 'text'},
            {'label' : 'Name', 'fieldName': 'Name', 'type' : 'text'},
            {'label' : 'Type', 'fieldName': 'Type__c', 'type' : 'text'},
            {'label' : 'Status', 'fieldName': 'Status__c', 'type' : 'text'},
            {'label' : 'Cost', 'fieldName': 'Cost__c', 'type' : 'text'},
            {'label' : 'Price per participant', 'fieldName': 'Price_per_participant__c', 'type' : 'text'},
            {'label' : 'Number of participants', 'fieldName': 'Number_of_participants__c', 'type' : 'text'},
            {'label' : 'Scoring', 'fieldName': 'Scoring__c', 'type' : 'text'},
            {'label' : 'Start date', 'fieldName': '	Start_Date__c', 'type' : 'text'},
            {'label' : 'End date', 'fieldName': 'End_Date__c', 'type' : 'text'},
            {type: 'action', typeAttributes: {rowActions: actions}}
        ]);

        helper.doInit(component, helper);
    },

    onRowActions : function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        //component.set('v.selectedWebinar', row);
        switch (action.name) {
            case 'register':
                helper.registerUser(component, helper, row);
                break;
        }
    },

    handleRegisterEvent : function(component, event, helper) {
        helper.doInit(component, helper);
    },

    closeModal: function(component, event, helper) { 
        component.set("v.isModalOpen", false);
    },
    
    // submitDetails: function(component, event, helper) {
    //     const choice = component.get('v.isApprove');
    //     let selectedWebinar = component.get('v.selectedWebinar');
    //     switch (choice) {
    //         case true:
    //             helper.approveWebinarStatus(component, helper, selectedWebinar);
    //             break;
    //         case false:
    //             helper.rejectWebinarStatus(component, helper, selectedWebinar);
    //             break;
    //     }
    //     component.set("v.isModalOpen", false);
    // }
});