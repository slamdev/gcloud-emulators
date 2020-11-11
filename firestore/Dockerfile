ARG  GCLOUD_VERSION
FROM google/cloud-sdk:${GCLOUD_VERSION}-alpine

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1

RUN apk --update add openjdk11-jre \
 && gcloud beta config list \
 && gcloud components install cloud-firestore-emulator

EXPOSE 8618

HEALTHCHECK --interval=2s --timeout=1s \
 CMD curl -f http://localhost:8085/v1/projects/any/databases/\(default\)/documents/ || exit 1

ENTRYPOINT [ \
  "gcloud", "beta", "emulators", "firestore", "start", \
  "--log-http", "--verbosity=debug", "--user-output-enabled", \
  "--host-port=0.0.0.0:8085" \
]
