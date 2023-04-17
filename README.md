# SageMaker LLM Tutorial

## Outline

The tutorial consists of:

1. Launching and using LLMs on SageMaker Jumpstart ([see tutorial here](./jumpstart.md))
2. Deploying models from HuggingFace Model Hub to SageMaker
    1. Deploy directly using weights from HuggingFace model hub ([see tutorial here](./notebooks/huggingface_deployment.ipynb))
    2. Deploy using packaged weights in S3 and in network isolation mode ([see tutorial here](./notebooks/huggingface_s3_packaged.ipynb))
3. Model acceleration and quantized models
    1. Using DeepSpeed and HuggingFace Accelerate to improve inference performance
4. LLM Fine-tuning and Applications
    1. Using Langchain for composability and building apps ([see tutorial here](./notebooks/sagemaker-jumpstart-langchain.ipynb))

Credit for sources used to come up with the tutorial is mentioned in each individual tutorial.