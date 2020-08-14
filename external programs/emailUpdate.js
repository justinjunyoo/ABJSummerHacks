const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

//Cloud function that triggers on document update
exports.onItemCreation = functions.firestore.document('TexasTotal/{docId}')
.onCreate(async(snapshot, context) => {
    const itemDataSnap = await snapshot.ref.get();
    const emails = admin.firestore().collection('emails').doc('addresses');
    const emaildata = await emails.get();
    const finalemail = emaildata.data();
    return admin.firestore().collection('mail').add({
       to: finalemail.emails,
       message: {
         subject: 'CovidTexas Update !',
         html: 'Texas now has a total of '+ itemDataSnap.data().Cases +' cases and ' + itemDataSnap.data().Deaths + ' deaths. Stay safe and wear a mask!'
       }
     }).then(() => console.log('Queued email for delivery!'));
});
