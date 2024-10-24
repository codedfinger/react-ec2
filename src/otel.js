// src/otel.js
import { WebTracerProvider } from '@opentelemetry/tracing';
import { CollectorTraceExporter } from '@opentelemetry/exporter-collector';
import { registerInstrumentations } from '@opentelemetry/instrumentation';

const exporter = new CollectorTraceExporter({
  url: 'http://otel-collector:4317', // Use your collector's IP
});

const provider = new WebTracerProvider({
  resource: {
    // Set the service name to identify your application
    service: 'kito',
  },
});

provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
provider.register();
registerInstrumentations({
  tracerProvider: provider,
});
