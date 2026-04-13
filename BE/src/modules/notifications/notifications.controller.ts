import { Request, Response } from 'express';
import { NotificationsService } from './notifications.service';

const notificationsService = new NotificationsService();

export class NotificationsController {
  async listMine(req: Request, res: Response) {
    try {
      const data = await notificationsService.listMine(req.userId!);
      return res.status(200).json({ data });
    } catch (error) {
      return res.status(500).json({
        message: 'Không lấy được notifications',
        error,
      });
    }
  }

  async respond(req: Request, res: Response) {
    try {
      const notificationId = Number(req.params.id);
      const action = req.body.action as 'xacnhan' | 'huy';

      if (Number.isNaN(notificationId)) {
        return res.status(400).json({
          message: 'notificationId không hợp lệ',
        });
      }

      if (!['xacnhan', 'huy'].includes(action)) {
        return res.status(400).json({
          message: 'action phải là xacnhan hoặc huy',
        });
      }

      const data = await notificationsService.respond(
        req.userId!,
        notificationId,
        action,
      );

      return res.status(200).json({
        message: 'Xử lý notification thành công',
        data,
      });
    } catch (error: any) {
      return res.status(400).json({
        message: error.message || 'Không xử lý được notification',
        error,
      });
    }
  }
}