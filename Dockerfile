# ---- Builder Stage ----
# Use the Ubuntu 24.04 ("noble") based image, which has the required GLIBC >= 2.38
FROM ubuntu/python:3.12-24.04 AS builder

# Create a virtual environment for a clean installation
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install the genai-perf package
RUN pip install --no-cache-dir genai-perf


# ---- Final Stage ----
# Use the same Ubuntu 24.04 based image for the final, minimal environment
FROM ubuntu/python:3.12-24.04

# Copy the virtual environment from the builder stage
COPY --from=builder /opt/venv /opt/venv

# Create a dedicated, non-root user for security
RUN useradd --system --no-create-home appuser
USER appuser

# Add the venv to the PATH for the non-root user
ENV PATH="/opt/venv/bin:$PATH"

# Set the entrypoint to the genai-perf command
ENTRYPOINT ["genai-perf"]
