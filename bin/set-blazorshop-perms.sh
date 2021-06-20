#!/bin/bash

set -e

if [[ -z "${GOOGLE_CLOUD_PROJECT}" ]]; then
  echo "Please make sure GOOGLE_CLOUD_PROJECT is defined before running this script."
  exit 1
fi

echo "Enabling the Cloud Resource Manager API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable cloudresourcemanager.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the Cloud Build API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable cloudbuild.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the Container Registry API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable containerregistry.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the Cloud Run API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable run.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the SQL Admin API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable sqladmin.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the Cloud Storage API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable storage.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the Cloud Source Repositories API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable sourcerepo.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Enabling the Secrets Manager API for project $GOOGLE_CLOUD_PROJECT..."
gcloud services enable secretmanager.googleapis.com --project=$GOOGLE_CLOUD_PROJECT

echo "Retrieving Project ID for project $GOOGLE_CLOUD_PROJECT..."
PROJECT_NUM=$(gcloud projects describe $GOOGLE_CLOUD_PROJECT --format='value(projectNumber)')

echo "Found project number: ${PROJECT_NUM}"

echo "Applying IAM Policy Binding..."
gcloud iam service-accounts add-iam-policy-binding \
  ${PROJECT_NUM}-compute@developer.gserviceaccount.com \
  --member=serviceAccount:${PROJECT_NUM}@cloudbuild.gserviceaccount.com \
  --role=roles/iam.serviceAccountUser \
  --project=${GOOGLE_CLOUD_PROJECT}

echo "Applying IAM Roles..."
gcloud iam service-accounts add-iam-policy-binding ${PROJECT_NUM}-compute@developer.gserviceaccount.com --member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com --role=roles/iam.securityAdmin

gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com --role=roles/editor
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com --role=roles/storage.admin
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com --role=roles/iam.securityAdmin
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com --role=roles/source.admin
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com --role=roles/secretmanager.admin


gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}@cloudbuild.gserviceaccount.com --role=roles/storage.admin
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} --member=serviceAccount:${PROJECT_NUM}@cloudbuild.gserviceaccount.com --role=roles/cloudbuild.builds.builder