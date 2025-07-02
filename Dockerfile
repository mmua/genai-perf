FROM python:3.10-slim

# Install GenAI-Perf CLI (client-only, no GPU needed)
RUN pip install --no-cache-dir genai-perf==0.0.15 \
    && pip cache purge

ENTRYPOINT ["genai-perf"] 