"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateSafeZoneSchema = exports.createSafeZoneSchema = void 0;
const zod_1 = require("zod");
exports.createSafeZoneSchema = zod_1.z.object({
    target_uid: zod_1.z.string().uuid(),
    name: zod_1.z.string().trim().min(1, 'name khong duoc de trong'),
    center_latitude: zod_1.z.number().min(-90).max(90),
    center_longitude: zod_1.z.number().min(-180).max(180),
    radius_meters: zod_1.z.number().int().positive(),
    is_active: zod_1.z.boolean().optional(),
});
exports.updateSafeZoneSchema = zod_1.z.object({
    name: zod_1.z.string().trim().min(1, 'name khong duoc de trong').optional(),
    center_latitude: zod_1.z.number().min(-90).max(90).optional(),
    center_longitude: zod_1.z.number().min(-180).max(180).optional(),
    radius_meters: zod_1.z.number().int().positive().optional(),
    is_active: zod_1.z.boolean().optional(),
});
