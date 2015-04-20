.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var privateScope = {
    getDatabase: function() {
        var db = Sql.LocalStorage.openDatabaseSync("harbour-wlan-keyboard", "1.0", "DB for sailfish-wlan-keyboard", 100000);
        try {
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)');
                //var table = tx.executeSql('SELECT * FROM settings');
            });
        } catch(err) {
            return err;
        }
        return db;
    }
}

function initSettings() {
   console.log("start initSettings")
   privateScope.getDatabase().transaction(function(tx) {
       tx.executeSql('DROP TABLE IF EXISTS settings');
   });
}

function isEmpty() {
    var init = true;
     privateScope.getDatabase().transaction(function(tx) {
         var table = tx.executeSql('SELECT * FROM settings');
         init = table.rows.lenght === 0 ? true: false;
     });
    return init;
}

function set(key, value) {
    privateScope.getDatabase().transaction( function(tx){
        tx.executeSql('INSERT OR REPLACE INTO settings VALUES(?, ?)', [key, value]);
       var rs = tx.executeSql('SELECT value FROM settings WHERE key=?;', [key]);
        value = rs.rows.item(0).value;
    });

    console.log("set property: " + key + ": " + value)
}

function get(key, defvalue) {
    var res = null;
    privateScope.getDatabase().transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM settings WHERE key=?;', [key]);
        if (rs.rows.length) {
            res = rs.rows.item(0).value
        }
    });
    var returnVal =  ((typeof(res) === 'undefined') || (res === null)) ? defvalue : res;
    console.log("get property: " + key + ": " + returnVal)
    return returnVal
}
