"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PushDeliveryService = void 0;
const firebase_1 = require("../../config/firebase");
const push_tokens_service_1 = require("../push-tokens/push-tokens.service");
const pushTokensService = new push_tokens_service_1.PushTokensService();
class PushDeliveryService {
    async sendToUser(params) {
        const tokens = await pushTokensService.getTokensByUid(params.uid);
        if (tokens.length === 0) {
            return;
        }
        const response = await firebase_1.firebaseMessaging.sendEachForMulticast({
            tokens,
            notification: {
                title: params.title,
                body: params.body,
            },
            data: params.data,
            android: {
                priority: 'high',
                notification: {
                    channelId: 'family_guard_high_importance',
                },
            },
            apns: {
                headers: {
                    'apns-priority': '10',
                },
            },
        });
        const invalidTokens = [];
        response.responses.forEach((item, index) => {
            if (item.success) {
                return;
            }
            const errorCode = item.error?.code ?? '';
            if (errorCode.includes('registration-token-not-registered') ||
                errorCode.includes('invalid-registration-token')) {
                invalidTokens.push(tokens[index]);
            }
        });
        if (invalidTokens.length > 0) {
            await pushTokensService.deleteTokens(invalidTokens);
        }
    }
}
exports.PushDeliveryService = PushDeliveryService;
