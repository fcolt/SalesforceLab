({
    handleSuccess : function(component) {
        alert('CreatedAccount')
        let appEvent = $A.get("e.c:registerEvent");
        appEvent.fire();
    }
})
