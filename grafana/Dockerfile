FROM grafana/grafana
COPY ./install-plugin.sh /install-plugin.sh
COPY ./configure.sh /configure.sh
COPY ./run-and-configure.sh /run-and-configure.sh
COPY ./dashboard.json /dashboard.json
COPY ./datasource.json /datasource.json
ENV GRAFANA_PLUGIN_URL="https://github.com/gnocchixyz/grafana-gnocchi-datasource/releases/download/1.7.0/gnocchixyz-gnocchi-datasource-1.7.0.tar.gz"
RUN /install-plugin.sh
USER root
ENTRYPOINT ["/run-and-configure.sh"]
