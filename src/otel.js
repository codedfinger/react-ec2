// src/otel.js
import { WebTracerProvider } from '@opentelemetry/sdk-trace-web';
import { CollectorTraceExporter } from '@opentelemetry/exporter-collector';
import { SimpleSpanProcessor } from '@opentelemetry/tracing';
import { registerInstrumentations } from '@opentelemetry/instrumentation';

// Create a trace exporter
const exporter = new CollectorTraceExporter({
  url: 'http://otel-collector:4317', // Update with your collector's IP
});

// Create a WebTracerProvider
const provider = new WebTracerProvider({
  resource: {
    // Set the service name to identify your application
    service: 'kito',
  },
});

// Add the exporter and register the provider
provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
provider.register();

// Optional: Register automatic instrumentation for supported libraries
registerInstrumentations({
  tracerProvider: provider,
});
