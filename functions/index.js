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
        });
    }
});
