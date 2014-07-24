function addUser() {
    var users = Alloy.Collections.users;

    // Create a new model for the user collection
    var user = Alloy.createModel('User', {
        name : $.firstNameField.value + " " + $.lastNameField.value
    });

    // add new model to the global collection
    users.add(user);

    // TODO: save the model to persistent storage
    //user.save();

    // reload the tasks
    users.fetch();

    closeWindow();
}

function focusTextField() {
    $.firstNameField.focus();
}

function closeKeyboard(e) {
    e.source.blur();
}

function closeWindow() {
    $.addWin.close();
}
