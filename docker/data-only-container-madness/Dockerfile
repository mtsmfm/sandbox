FROM debian:jessie
RUN useradd mickey
RUN mkdir /foo && touch /foo/bar && chown -R mickey:mickey /foo
USER mickey
CMD ls -lh /foo
