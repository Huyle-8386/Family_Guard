"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LocationsController = void 0;
const locations_types_1 = require("./locations.types");
const locations_service_1 = require("./locations.service");
const locationsService = new locations_service_1.LocationsService();
class LocationsController {
    async updateMe(req, res) {
        try {
            const parsed = locations_types_1.updateMyLocationSchema.safeParse(req.body);
            if (!parsed.success) {
                return res.status(400).json({
                    message: 'Du lieu khong hop le',
                    errors: parsed.error.flatten(),
                });
            }
            const data = await locationsService.updateMyLocation(req.userId, parsed.data);
            return res.status(200).json({ message: 'Cap nhat vi tri thanh cong', data });
        }
        catch (error) {
            return res.status(400).json({
                message: error?.message || 'Khong cap nhat duoc vi tri',
            });
        }
    }
    async getMe(req, res) {
        try {
            const data = await locationsService.getMyLocation(req.userId);
            return res.status(200).json({ data });
        }
        catch (error) {
            return res.status(500).json({
                message: error?.message || 'Khong lay duoc vi tri hien tai',
            });
        }
    }
    async getFamily(req, res) {
        try {
            const data = await locationsService.getFamilyLocations(req.userId);
            return res.status(200).json({ data });
        }
        catch (error) {
            return res.status(500).json({
                message: error?.message || 'Khong lay duoc vi tri gia dinh',
            });
        }
    }
}
exports.LocationsController = LocationsController;
