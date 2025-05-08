# Використовуємо Node.js образ
FROM node:7.8.0

# Робоча директорія
WORKDIR /opt

COPY . .

ARG PORT=3000
ENV PORT=${PORT}

RUN npm install

CMD ["sh", "-c", "npm run start -- --port $PORT"]