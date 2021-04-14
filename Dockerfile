FROM node:10 AS build-env
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
RUN npm install --production
COPY . .
RUN ["node_modules/next/dist/bin/next", "build"]

FROM gcr.io/distroless/nodejs:10 AS prod
COPY --from=build-env /app /app
WORKDIR /app
EXPOSE 3000
CMD ["node_modules/next/dist/bin/next", "start"]

