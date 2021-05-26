FROM node:14.16.1-alpine3.11 as builder
WORKDIR /app
COPY . .
RUN npm install --only=development
RUN npm run build

FROM node:14.16.1-alpine3.11
WORKDIR /app
COPY package.json .
COPY package-lock.json .
COPY prisma .
RUN npm install --only=production
RUN npm run prisma:generate
COPY --from=builder /app/build build
ENV NODE_ENV=production
CMD npm run start
