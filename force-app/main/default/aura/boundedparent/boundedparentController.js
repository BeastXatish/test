({
	updateparentvariable : function(component, event, helper) {
		component.set("v.parentvar", "Updated Parent Value upon Button Click")
	},
    onparentvarchange : function(component, event, helper) {
		console.log("Parent Value has been Changed");
        console.log("Old Value: " +event.getParam("oldvalue"));
        console.log("New Value: " +event.getParam("value"));
	}
})