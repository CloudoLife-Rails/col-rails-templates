# config/initializers/opentelemetry.rb

require "opentelemetry/sdk"
require "opentelemetry/instrumentation/all"
require "opentelemetry-exporter-otlp"

OpenTelemetry::SDK.configure do |c|
  c.add_span_processor(
    OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
      OpenTelemetry::Exporter::OTLP::Exporter.new(
        endpoint: ENV['OTEL_EXPORTER_OTLP_ENDPOINT'],
        headers: {
          "Authorization" => "Basic ${ENV['OTEL_EXPORTER_OTLP_HEADERS_AUTHORIZATION']}",
        },
        ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
      )
    )
  )

  c.service_name = "#{Rails.application.class.name}-#{Rails.env}"
  c.use_all() # enables all instrumentation!
end
