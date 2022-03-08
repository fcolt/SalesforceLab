({
    doInit : function(component, helper) {
        // Apex function usage
        const getWebinars = component.get("c.getWebinars");
        getWebinars.setParams({
            webinarLimit: component.get("v.webinarsLimit")
        });
        getWebinars.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.webinars", response.getReturnValue());
            }
            else {
                console.log("Something went horribly wrong");
            }
        });
        $A.enqueueAction(getWebinars);
        // End of apex function call
    },

    //approve
    approveWebinarStatus : function(component, helper, row) {
        // Confirm is native JS pop-up window that returns true/false based on user's choice.
        //if (confirm('Are you sure you want to approve ' + row.Name + '?')) {
            const approveWebinar = component.get("c.approveWebinar");
            approveWebinar.setParam('webinar', row);

            approveWebinar.setCallback(this, function(response) {
                const state = response.getState();
                if (state === "SUCCESS") {
                    helper.doInit(component, helper);
                    component.find("notifLibrary").showToast({
                        title: 'Success',
                        message: 'Webinar approved',
                        variant: 'success'
                    });
                }
                else if (state === "ERROR") {
                    // Usage of lightning:notificationsLibrary from cmp
                    component.find("notifLibrary").showToast({
                        title: 'Something went wrong',
                        message: response.getError()[0].message,
                        variant: 'error'
                    });
                }

            });
            $A.enqueueAction(approveWebinar);
        //}
    },

    //reject
    rejectWebinarStatus : function(component, helper, row) {
        // Confirm is native JS pop-up window that returns true/false based on user's choice.
        //if (confirm('Are you sure you want to reject ' + row.Name + '?')) {
            const rejectWebinar = component.get("c.rejectWebinar");
            rejectWebinar.setParam('webinar', row);
            console.log(row);
            rejectWebinar.setCallback(this, function(response) {
                const state = response.getState();
                if (state === "SUCCESS") {
                    helper.doInit(component, helper);
                    component.find("notifLibrary").showToast({
                        title: 'Success',
                        message: 'Webinar rejected',
                        variant: 'error'
                    });
                }
                else if (state === "ERROR") {
                    // Usage of lightning:notificationsLibrary from cmp
                    component.find("notifLibrary").showToast({
                        title: 'Something went wrong',
                        message: response.getError()[0].message,
                        variant: 'error'
                    });
                }
            });
            $A.enqueueAction(rejectWebinar);
        //}
    },
});