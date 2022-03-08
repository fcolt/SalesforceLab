({
    doInit : function(component) {
        // Apex function usage
        const getFilteredWebinars = component.get("c.getFilteredWebinars");
        // getWebinars.setParams({
        //     webinarLimit: component.get("v.webinarsLimit")
        // });
        getFilteredWebinars.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.webinars", response.getReturnValue());
            }
            else {
                console.log("Something went horribly wrong");
            }
        });
        $A.enqueueAction(getFilteredWebinars);
        // End of apex function call
    },

    registerUser : function(component,helper,row) {
        const registerWebinar = component.get("c.registerWebinar");
        registerWebinar.setParam('webinarId', row.Id);
        alert(row.Id);
        registerWebinar.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                helper.doInit(component, helper);
                component.find("notifLibrary").showToast({
                    title: 'Success',
                    message: 'Registered to this webinar',
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
        $A.enqueueAction(registerWebinar);
    }
});