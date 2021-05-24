##Submitting our training job to gcp
gcloud ml-engine jobs submit training mnist_recognition3 --package-path=./trainer --module-name trainer.task --job-dir=gs://pawan-bucket-9999/output1  --config=config.yaml --region=us-east1

##Submitting our asynchronous training job to gcp
 gcloud ml-engine jobs submit training mnist_recognition_async8 --package-path=./trainerAsync --module-name trainerAsync.task --staging-bucket gs://pawan-bucket-9999 --config=configAsync.yaml --region=us-east1