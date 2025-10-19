ARG BUILD_API_URL=http://localhost:5000

FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM node:20-alpine AS build

ARG BUILD_API_URL

WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=production
ENV NEXT_PUBLIC_BASE_URL=http://host.docker.internal:5000/api/v1
ENV NEXT_PUBLIC_IMAGE_SERVER=https://pub-43a158751ca142c3a51b1b0baa14b50b.r2.dev
RUN npm run build

FROM node:20-alpine AS runner

ARG BUILD_API_URL

WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_PUBLIC_BASE_URL=http://host.docker.internal:5000/api/v1
ENV NEXT_PUBLIC_IMAGE_SERVER=https://pub-43a158751ca142c3a51b1b0baa14b50b.r2.dev
ENV PORT=3002
COPY --from=build /app/.next ./.next
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/public ./public
COPY --from=build /app/package*.json ./
EXPOSE 3002
CMD ["npm","run","start","--","-p","3002"]
