"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SafeZonesController = void 0;
const safe_zones_types_1 = require("./safe-zones.types");
const safe_zones_service_1 = require("./safe-zones.service");
class SafeZonesController {
    async create(req, res) {
        try {
            const parsed = safe_zones_types_1.createSafeZoneSchema.safeParse(req.body);
            if (!parsed.success) {
                return res.status(400).json({
                    message: 'Du lieu khong hop le',
                    errors: parsed.error.flatten(),
                });
            }
            const data = await safe_zones_service_1.safeZonesService.createSafeZone(req.userId, parsed.data);
            return res.status(201).json({ message: 'Tao vung an toan thanh cong', data });
        }
        catch (error) {
            return res.status(400).json({
                message: error?.message || 'Khong tao duoc vung an toan',
            });
        }
    }
    async list(req, res) {
        try {
            const data = await safe_zones_service_1.safeZonesService.listSafeZones(req.userId);
            return res.status(200).json({ data });
        }
        catch (error) {
            return res.status(500).json({
                message: error?.message || 'Khong lay duoc danh sach vung an toan',
            });
        }
    }
    async update(req, res) {
        try {
            const id = Number(req.params.id);
            if (Number.isNaN(id)) {
                return res.status(400).json({ message: 'safeZoneId khong hop le' });
            }
            const parsed = safe_zones_types_1.updateSafeZoneSchema.safeParse(req.body);
            if (!parsed.success) {
                return res.status(400).json({
                    message: 'Du lieu khong hop le',
                    errors: parsed.error.flatten(),
                });
            }
            if (Object.keys(parsed.data).length === 0) {
                return res.status(400).json({ message: 'Khong co truong nao de cap nhat' });
            }
            const data = await safe_zones_service_1.safeZonesService.updateSafeZone(req.userId, id, parsed.data);
            return res.status(200).json({ message: 'Cap nhat vung an toan thanh cong', data });
        }
        catch (error) {
            return res.status(400).json({
                message: error?.message || 'Khong cap nhat duoc vung an toan',
            });
        }
    }
    async delete(req, res) {
        try {
            const id = Number(req.params.id);
            if (Number.isNaN(id)) {
                return res.status(400).json({ message: 'safeZoneId khong hop le' });
            }
            const data = await safe_zones_service_1.safeZonesService.deleteSafeZone(req.userId, id);
            return res.status(200).json({ message: 'Xoa vung an toan thanh cong', data });
        }
        catch (error) {
            return res.status(400).json({
                message: error?.message || 'Khong xoa duoc vung an toan',
            });
        }
    }
}
exports.SafeZonesController = SafeZonesController;
