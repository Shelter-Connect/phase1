const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();

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