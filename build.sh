#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Python dependencies
echo "Installing Python dependencies..."
pip install -r requirements.txt

# Install Node.js dependencies
echo "Installing Node.js dependencies..."
npm install

# Build Tailwind CSS
echo "Building Tailwind CSS..."
npm run build:css

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --no-input

# Run migrations
echo "Applying database migrations..."
python manage.py migrate

# Create superuser if environment variable is set
if [[ -n $CREATE_SUPERUSER && -n $DJANGO_SUPERUSER_EMAIL ]]; then
  echo "Checking for superuser existence..."
  if ! python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(email='$DJANGO_SUPERUSER_EMAIL').exists()"; then
    echo "Creating superuser..."
    python manage.py createsuperuser --no-input --email "$DJANGO_SUPERUSER_EMAIL"
  else
    echo "Superuser with email $DJANGO_SUPERUSER_EMAIL already exists."
  fi
fi

echo "Deployment complete."
