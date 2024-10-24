const { NodeSDK } = require('@opentelemetry/sdk-node');
const { CollectorTraceExporter } = require('@opentelemetry/exporter-collector');

const sdk = new NodeSDK({
  traceExporter: new CollectorTraceExporter({
    url: 'http://otel-collector:4317', // Use the gRPC port for tracing
  }),
});

sdk.start()
  .then(() => console.log('OpenTelemetry initialized'))
  .catch((err) => console.log('Error initializing OpenTelemetry', err));
