provider "google" {
  credentials = file("keys/credentials.json")
  project     = "prod"
  region      = "us-central1"
}
