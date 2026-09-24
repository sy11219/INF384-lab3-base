FROM public.ecr.aws/lambda/nodejs:20 AS build

WORKDIR /build

COPY package.json package-lock.json ./
RUN npm ci

COPY src ./src
RUN npm run build

FROM public.ecr.aws/lambda/nodejs:20

COPY --from=build /build/dist/handler.js ${LAMBDA_TASK_ROOT}/handler.js

CMD ["handler.handler"]
