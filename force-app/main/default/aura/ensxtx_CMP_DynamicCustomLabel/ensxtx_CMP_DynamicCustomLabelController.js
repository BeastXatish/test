({
    onInit: function(component, event, helper) {
        let customLabel = component.get('v.customLabel');
        if (customLabel) {
            console.log('get custom label');
            let reference = $A.getReference('$Label.c.' + customLabel);
            component.set('v.obj.lbl', reference);
        }
    },

    handleChange: function(component, event, helper) {
        console.log('handle custom label change');
    }
})