#!/bin/bash
# Environment setup 
export TOKENIZERS_PARALLELISM=false
export CUDA_VISIBLE_DEVICES=2

# (1) fine-tuning method
use_lora=True
method_name=sift   #lora,adalora,dora,pissa,rslora,olora,eva // sift,

# (2) full fine-tuning
# use_lora=False

# Experiment configuration
task=rte
exp_name=roberta_${method_name}_${task}
lr=5e-5
lr_ratio=2
target=query,value  #query,value,key

# Execute command  
python EfficientFT/run.py \
  --model_name_or_path roberta-base \
  --task_name $task \
  --use_lora $use_lora\
  --method_name $method_name\
  --target_modules $target \
  --do_train  True\
  --do_predict False \
  --per_device_train_batch_size 32 \
  --per_device_eval_batch_size 128 \
  --max_seq_length 128 \
  --eval_steps 500 \
  --save_steps 500 \
  --logging_steps 10 \
  --num_train_epochs 20 \
  --learning_rate $lr \
  --lr_ratio $lr_ratio \
  --lora_rank 8 \
  --lora_alpha 8 \
  --lr_scheduler_type 'linear' \
  --adam_beta1 0.9 \
  --adam_beta2 0.99 \
  --adam_epsilon 1e-8 \
  --output_dir output/$exp_name/lr-${lr}_ratio-${lr_ratio}-${target} \
  --logging_dir output/$exp_name/lr-${lr}_ratio-${lr_ratio}/logs/ \
  --evaluation_strategy steps \
  --save_strategy steps \
  --report_to tensorboard \
  --keep_checkpoints eval \
  --overwrite_output_dir \
  --ignore_mismatched_sizes \
  --save_total_limit 1 \
  --use_local True \
  --data_dir /.../data \
  --fp16 \