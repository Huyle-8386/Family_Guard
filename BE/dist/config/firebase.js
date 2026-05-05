"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.firebaseMessaging = void 0;
const app_1 = require("firebase-admin/app");
const messaging_1 = require("firebase-admin/messaging");
function parseServiceAccountFromEnv() {
    const raw = process.env.FIREBASE_SERVICE_ACCOUNT_JSON?.trim();
    if (!raw) {
        return null;
    }
    try {
        const parsed = JSON.parse(raw);
        return parsed;
    }
    catch (error) {
        console.error('FIREBASE_SERVICE_ACCOUNT_JSON is invalid JSON', error);
        return null;
    }
}
function initializeFirebaseApp() {
    if ((0, app_1.getApps)().length > 0) {
        return (0, app_1.getApps)()[0];
    }
    const serviceAccount = parseServiceAccountFromEnv();
    if (serviceAccount) {
        return (0, app_1.initializeApp)({
            credential: (0, app_1.cert)(serviceAccount),
        });
    }
    return (0, app_1.initializeApp)({
        credential: (0, app_1.applicationDefault)(),
    });
}
const firebaseApp = initializeFirebaseApp();
exports.firebaseMessaging = (0, messaging_1.getMessaging)(firebaseApp);
