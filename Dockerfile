FROM node:17.3.0-stretch AS build
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .
RUN yarn generate
RUN yarn build

FROM node:17.3.0-stretch AS production
WORKDIR /app
COPY . .
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist
CMD ["node", "dist/main.js"]