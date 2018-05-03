# Docker image for React Native (Android)
Ready build environment with Node.js, OpenJDK, and Android SDK.

## Building docker image
```
docker build -t react-native-gitlab-ci .
docker run --rm -it react-native-gitlab-ci bash
```

## Example of `gitlab-ci.yml`
```yaml
image: chinkang/react-native-gitlab-ci

before_script:
  - chmod +x ./android/gradlew

stages:
  - build

cache:
  key: ${CI_PROJECT_ID}
  paths:
    - node_modules/
    - android/.gradle/
    - chart/node_modules/

build:
  stage: build
  script:
    - yarn install
    - cd chart && yarn install && yarn build
    - cd ../android && ./gradlew assembleRelease
  artifacts:
    paths:
      - android/app/build/outputs/apk/release/

```

## Version 1.0
| Node.js  | OpenJDK     | Android SDK      |
|----------|-------------|------------------|
| 9.11.1   | 1.8.0_162   | 26.1.1 (3859397) |
