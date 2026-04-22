import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import authRoutes from './modules/auth/auth.routes';
import usersRoutes from './modules/users/users.routes';
import relationshipsRoutes from './modules/relationships/relationships.routes';
import notificationsRoutes from './modules/notifications/notifications.routes';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.get('/', (_req, res) => {
  res.json({ message: 'FamilyGuard Backend is running' });
});

app.use('/api', authRoutes);
app.use('/api', usersRoutes);
app.use('/api', relationshipsRoutes);
app.use('/api', notificationsRoutes);

export default app;