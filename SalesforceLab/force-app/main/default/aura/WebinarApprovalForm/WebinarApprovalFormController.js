({
    doInit : function(component, event, helper) {
        const actions = [
            {label: 'Approve', name: 'approveWebinar'},
            {'label' : 'Reject', 'name' : 'rejectWebinar'},
        ];
        component.set("v.columns", [
            {'label' : 'Name', 'fieldName': 'Name', 'type' : 'text'},
            {'label' : 'Approval Status', 'fieldName': 'Approval_Status__c', 'type': 'picklist'},
            {type: 'action', typeAttributes: {rowActions: actions}}
        ]);

        helper.doInit(component, helper);
    },

    onRowActions : function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        component.set('v.selectedWebinar', row);
        switch (action.name) {
            case 'approveWebinar':
                component.set('v.isApprove', true);
                component.set('v.isModalOpen', true);
                //helper.approveWebinarStatus(component, helper, row);
                break;
            case 'rejectWebinar':
                component.set('v.isApprove', false);
                component.set('v.isModalOpen', true);
                //helper.rejectWebinarStatus(component, helper, row);
                break;
        }
    },

    handleRegisterEvent : function(component, event, helper) {
        helper.doInit(component, helper);
    },

    closeModal: function(component, event, helper) { 
        component.set("v.isModalOpen", false);
    },
    
    submitDetails: function(component, event, helper) {
        const choice = component.get('v.isApprove');
        let selectedWebinar = component.get('v.selectedWebinar');
        switch (choice) {
            case true:
                helper.approveWebinarStatus(component, helper, selectedWebinar);
                break;
            case false:
                helper.rejectWebinarStatus(component, helper, selectedWebinar);
                break;
        }
        component.set("v.isModalOpen", false);
    }
});