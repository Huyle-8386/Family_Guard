import { Request, Response } from 'express';
import { UsersService } from './users.service';
import { updateMeSchema } from './users.validation';

const usersService = new UsersService();

export class UsersController {
  async getMe(req: Request, res: Response) {
    try {
      const data = await usersService.getMe(req.userId!);
      return res.json({ data });
    } catch (error) {
      return res.status(500).json({ message: 'Không lấy được thông tin user', error });
    }
  }

  async updateMe(req: Request, res: Response) {
    try {
      const parsed = updateMeSchema.safeParse(req.body);
      if (!parsed.success) {
        return res.status(400).json({ message: 'Dữ liệu không hợp lệ', errors: parsed.error.flatten() });
      }

      const data = await usersService.updateMe(req.userId!, parsed.data);
      return res.json({ message: 'Cập nhật thành công', data });
    } catch (error) {
      return res.status(500).json({ message: 'Không cập nhật được user', error });
    }
  }

  async searchUsers(req: Request, res: Response) {
    try {
      const q = String(req.query.q ?? '').trim();
      if (!q) {
        return res.status(400).json({ message: 'Thiếu từ khóa tìm kiếm' });
      }

      const data = await usersService.searchUsers(req.userId!, q);
      return res.json({ data });
    } catch (error) {
      return res.status(500).json({ message: 'Không tìm được user', error });
    }
  }
}