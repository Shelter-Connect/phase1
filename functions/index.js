const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();

//Sendgrid stuff
import d-fd10329c591d4fab9bd3504c2289a4d0 as sgMail from '@sendgrid/mail'
const API_KEY = functions.config();
sgMail.setAPIKey(API_KEY);

//send e-mail after sign-up
export const welcomeEmail = functions.auth.user().onCreate(user => {
    const msg = {
    to: user.email,
    from: 'linkare22@gmail.com'
    templateId: API_KEY}
})
return sgMail.send(msg)

exports.updateOrganizationInfo = functions.firestore.document('organizations/{uid}').onUpdate(async (doc, context) => {
    let updatedInfo = doc.after;
    let currentDonations = await db.collection('organizations').doc(context.params.uid).collection('currentDonations').get();
    for (const donation of currentDonations.docs) {
        let volunteerId = donation.data().volunteerId;
        let volunteerDonationReference = db.collection('volunteers').doc(volunteerId).collection('currentDonations').doc(donation.id);
        volunteerDonationReference.update({
            organizationAddress: updatedInfo.data().address,
            organizationDescription: updatedInfo.data().description,
            organizationLocation: updatedInfo.data().location,
            organizationName: updatedInfo.data().name,
            organizationEmail: updatedInfo.data().email,
            organizationWebsite: updatedInfo.data().website,
            organizationNumber: updatedInfo.data().number,
        });
    }
});

exports.updateVolunteerInfo = functions.firestore.document('volunteers/{uid}').onUpdate(async (doc, context) => {
    let updatedInfo = doc.after;
    let currentDonations = await db.collection('volunteers').doc(context.params.uid).collection('currentDonations').get();
    for (const donation of currentDonations.docs) {
        let organizationId = donation.data().organizationId;
        let organizationDonationReference = db.collection('organizations').doc(organizationId).collection('currentDonations').doc(donation.id);
        organizationDonationReference.update({
            volunteerName: updatedInfo.data().firstName + ' ' + updatedInfo.data().lastName,
        });
    }
});

exports.updateOrganizationCategories = functions.firestore.document('organizations/{uid}/requests/{item}').onUpdate(async (doc, context) => {
    let organizationReference = db.collection('organizations').doc(context.params.uid);
    let currentRequests = await organizationReference.collection('requests').get();
    let requests = new Set();
    for (const request of currentRequests.docs) {
        if (request.data().amount > 0) requests.add(request.data().category);
    }
    organizationReference.update({
        itemCategories: Array.from(requests)
    });
});