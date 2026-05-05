"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.uploadAvatarSchema = exports.updateMeSchema = void 0;
const zod_1 = require("zod");
exports.updateMeSchema = zod_1.z.object({
    name: zod_1.z.string().min(1).optional(),
    email: zod_1.z.string().email().optional(),
    phone: zod_1.z.string().min(8).max(20).optional(),
    birthday: zod_1.z.string().optional(),
    sex: zod_1.z.string().optional(),
    address: zod_1.z.string().optional(),
    role: zod_1.z.enum(['nguoichamsoc', 'nguoiduocchamsoc']).optional(),
    avata: zod_1.z.string().optional(),
});
exports.uploadAvatarSchema = zod_1.z.object({
    fileName: zod_1.z.string().min(1),
    mimeType: zod_1.z
        .string()
        .regex(/^image\/[a-zA-Z0-9.+-]+$/)
        .optional(),
    base64Data: zod_1.z.string().min(1),
});
