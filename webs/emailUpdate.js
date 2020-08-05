const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduledFunction = functions.pubsub.schedule('every 5 minutes').onRun((context) => {
  var webdriver = require ('selenium-webdriver'), By = webdriver.By;
  var driver = new webdriver.Builder().forBrowser('chrome').build();
  driver.get("https://www.worldometers.info/coronavirus/usa/texas/");
  
  var text = driver.findElement(webdriver.By.xpath('//*[@id="maincounter-wrap"]/div/span')).getText();
  // driver.findElement(By.xpath('//*[@id="maincounter-wrap"]/div/span').then(function(element){
  //   element.getText().then(function(text){
  //       console.log(text);
  //   });
  // });
  
  
  console.log(text);
  // return null;
});

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
