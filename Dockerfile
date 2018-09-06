
ARG IMAGE_ARG_IMAGE_TAG

FROM elasticsearch:${IMAGE_ARG_IMAGE_TAG:-2.4.4} as base

# see https://github.com/docker-library/elasticsearch/blob/master/2.4/Dockerfile
FROM scratch

COPY --from=base / /

ENV PATH /usr/share/elasticsearch/bin:$PATH

RUN set -ex \
  && usermod -u 1000 elasticsearch \
  && groupmod -g 1000 elasticsearch \
  && chown -hR elasticsearch:elasticsearch /usr/share/elasticsearch

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 9200 9300
CMD ["elasticsearch"]
