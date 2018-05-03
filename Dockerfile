FROM openjdk:8-jdk

# Preparing environment. lib32* are using by Android SDK
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bzip2 \
      unzip \
      xz-utils \
      wget \
      tar \
      lib32stdc++6 \
      lib32z1 && \
    rm -rf /var/lib/apt/lists/*;

###############################################
# Installing Node.js
###############################################

# Refer to https://nodejs.org/en/download/releases
ENV NODE_VERSION 9.11.1
RUN cd && \
    wget -q https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz && \
    tar -xzf node-v${NODE_VERSION}-linux-x64.tar.gz && \
    mv node-v${NODE_VERSION}-linux-x64 /opt/node && \
    rm node-v${NODE_VERSION}-linux-x64.tar.gz
ENV PATH ${PATH}:/opt/node/bin

RUN npm install -g yarn

###############################################
# Installing Android SDK
###############################################

# Refer to https://developer.android.com/studio/#downloads to get the CLI's latest version
# https://developer.android.com/studio/releases/sdk-tools
ENV ANDROID_SDK_FILENAME sdk-tools-linux-3859397.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
RUN cd /opt && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} -d ./android-sdk-linux && \
    rm ${ANDROID_SDK_FILENAME} && \
    printf 'y\ny\ny\ny\ny\ny\ny\ny\ny\ny' | sdkmanager --licenses && \
    sdkmanager "tools" "platform-tools"  && \
    sdkmanager "platforms;android-26" && \
    sdkmanager "build-tools;27.0.3" && \
    sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services"

