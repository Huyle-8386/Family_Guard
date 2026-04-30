"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateRelationshipSchema = exports.inviteRelationshipSchema = void 0;
const zod_1 = require("zod");
exports.inviteRelationshipSchema = zod_1.z.object({
    target_uid: zod_1.z.string().uuid(),
    relation_type: zod_1.z.string().min(1, 'relation_type không được để trống'),
    reverse_relation_type: zod_1.z
        .string()
        .min(1, 'reverse_relation_type không được để trống'),
});
exports.updateRelationshipSchema = zod_1.z.object({
    relation_type: zod_1.z.string().min(1, 'relation_type không được để trống'),
    reverse_relation_type: zod_1.z
        .string()
        .min(1, 'reverse_relation_type không được để trống')
        .optional(),
});
