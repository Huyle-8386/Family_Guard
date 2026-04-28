"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateMyLocationSchema = void 0;
const zod_1 = require("zod");
exports.updateMyLocationSchema = zod_1.z.object({
    latitude: zod_1.z.number().min(-90).max(90),
    longitude: zod_1.z.number().min(-180).max(180),
    accuracy: zod_1.z.number().nonnegative().optional(),
    speed: zod_1.z.number().nullable().optional(),
    address: zod_1.z.string().nullable().optional(),
    street: zod_1.z.string().nullable().optional(),
    ward: zod_1.z.string().nullable().optional(),
    district: zod_1.z.string().nullable().optional(),
    city: zod_1.z.string().nullable().optional(),
    country: zod_1.z.string().nullable().optional(),
    place_name: zod_1.z.string().nullable().optional(),
    timestamp: zod_1.z.string().datetime().nullable().optional(),
});
